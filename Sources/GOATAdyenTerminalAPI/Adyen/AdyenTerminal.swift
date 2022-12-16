//
//  AdyenTerminal.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

/// A representation of the hardware payment device. It allows to perform all the actions we need from the device: payments, refunds, etc.
public struct AdyenTerminal {
    public let ip: String
    public let saleID: String
    public let poiId: String
    public let encryptionCredentialDetails: EncryptionCredentialDetails

    public init(ip: String, saleID: String, poiId: String, encryptionCredentialDetails: EncryptionCredentialDetails) {
        self.ip = ip
        self.saleID = saleID
        self.poiId = poiId
        self.encryptionCredentialDetails = encryptionCredentialDetails
    }

    public func login(serviceID: String, saleSoftware: SaleSoftware, operatorID: String, totalsGroupID: String) async throws -> LoginResponse {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .login, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: saleID, pOIID: poiId)

        let saleTerminalData = SaleTerminalData(totalsGroupID: totalsGroupID)
        let loginRequest = LoginRequest(dateTime: Date(), saleSoftware: saleSoftware, saleTerminalData: saleTerminalData, operatorLanguage: .english, operatorID: operatorID)
        
        return try await self.perform(header: messageHeader, terminalRequest: loginRequest)
    }

    /// Perform a payment request on the hardware terminal.
    ///
    /// - Parameter serviceID: Your unique ID for this request, consisting of 1-10 alphanumeric characters. Must be unique within the last 48 hours for the terminal (POIID) being used.
    /// - Parameter currency: The transaction currency ISO code
    /// - Parameter amountCents: The final transaction amount expressed in cents.
    ///
    /// - Returns: The result of the payment
    ///
    public func pay(transactionID: String, serviceID: String, currency: String, amountCents: Int) async throws -> PaymentResponse {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .payment, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: saleID, pOIID: poiId)
        
        let saleData = SaleData(saleTransactionID: TransactionIDType(transactionID: transactionID, timeStamp: Date()))
        let paymentTransaction = PaymentTransaction(amountsReq: AmountsReq(currency: currency, requestedAmount: (Float(amountCents) / 100.0)))
        let paymentRequest = PaymentRequest(saleData: saleData, paymentTransaction: paymentTransaction)
        
        return try await self.perform(header: messageHeader, terminalRequest: paymentRequest)
    }
    
    public func reversal(serviceID: String, originalTransaction: TransactionIDType) async throws -> ReversalResponse {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .reversal, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: saleID, pOIID: poiId)

        let reversalRequest = ReversalRequest(originalPOITransaction: OriginalPOITransaction(pOITransactionID: originalTransaction), reversalReason: .merchantCancel)
        
        return try await self.perform(header: messageHeader, terminalRequest: reversalRequest)
    }

    public func getTotals() async throws -> GetTotalsResponse {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .getTotals, messageType: .request, serviceID: UUID().description.suffix(10).description, deviceID: nil, saleID: saleID, pOIID: poiId)

        let getTotalsRequest = GetTotalsRequest()
        
        return try await self.perform(header: messageHeader, terminalRequest: getTotalsRequest)
    }

    public func abortPayment(serviceID: String, abortServiceID: String) async throws {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .abort, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: saleID, pOIID: poiId)
        let messageReference = MessageReference(messageCategory: .payment, serviceID: abortServiceID, deviceID: nil, saleID: saleID, pOIID: poiId)
        let abortRequest = AbortRequest(messageReference: messageReference, abortReason: "MerchantAbort")
        let request = AdyenTerminalRequest<AbortRequest>(saleToPOIRequest: SaleToPOIRequest(messageHeader: messageHeader, request: abortRequest))

        let api = AdyenTerminalAPI(terminal: self)
        try await api.performResponseless(request: request)
    }

    public func transactionStatus(serviceID: String, statusServiceID: String) async throws -> TransactionStatusResponse {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .transactionStatus, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: saleID, pOIID: poiId)
        
        let messageReference = MessageReference(messageCategory: .payment, serviceID: statusServiceID, deviceID: nil, saleID: saleID, pOIID: poiId)
        let transactionStatusRequest = TransactionStatusRequest(messageReference: messageReference, receiptReprintFlag: false, documentQualifier: [])
        
        return try await self.perform(header: messageHeader, terminalRequest: transactionStatusRequest)
    }
    
    private func perform<P:TerminalRequest, R: TerminalResponse>(header: MessageHeader, terminalRequest: P) async throws -> R {
        let request = AdyenTerminalRequest<P>(saleToPOIRequest: SaleToPOIRequest(messageHeader: header, request: terminalRequest))

        let api = AdyenTerminalAPI(terminal: self)
        let terminalResponse: AdyenTerminalResponse<PaymentResponse> = try await api.perform(request: request)
        
        let response = terminalResponse.saleToPOIResponse.response.response

        guard response.result == .success else {
            if let condition = response.errorCondition {
                throw AdyenTerminalAPIError.adyen(error: condition.rawValue, additionalResponse: response.parsedAdditionalResponse["message"])
            } else {
                throw AdyenTerminalAPIError.unknown(error: "Unknown error condition")
            }
        }
        
        return terminalResponse.saleToPOIResponse.response as! R
    }
}

