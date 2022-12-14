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
    public let name: String
    public let location: String
    public let number: Int
    public let poiId: String
    public let encryptionCredentialDetails: EncryptionCredentialDetails

    public init(ip: String, name: String, location: String, number: Int, poiId: String, encryptionCredentialDetails: EncryptionCredentialDetails) {
        self.ip = ip
        self.name = name
        self.location = location
        self.number = number
        self.poiId = poiId
        self.encryptionCredentialDetails = encryptionCredentialDetails
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
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .payment, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)
        let saleData = SaleData(saleTransactionID: TransactionIDType(transactionID: transactionID, timeStamp: Date()))
        let paymentTransaction = PaymentTransaction(amountsReq: AmountsReq(currency: currency, requestedAmount: (Float(amountCents) / 100.0)))
        let paymentRequest = PaymentRequest(saleData: saleData, paymentTransaction: paymentTransaction)
        let request = AdyenTerminalRequest<PaymentRequest>(saleToPOIRequest: SaleToPOIRequest(messageHeader: messageHeader, request: paymentRequest))

        let api = AdyenTerminalAPI(terminal: self)
        let terminalResponse: AdyenTerminalResponse<PaymentResponse> = try await api.perform(request: request)
        
        let response = terminalResponse.saleToPOIResponse.response.response

        guard response.result == .success else {
            if let condition = response.errorCondition {
                throw AdyenTerminalAPIError.adyen(error: condition.rawValue)
            } else {
                throw AdyenTerminalAPIError.unknown(error: "Unknown error condition")
            }
        }
        
        return terminalResponse.saleToPOIResponse.response
    }
    
    public func abortPayment(serviceID: String, abortServiceID: String) async throws {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .abort, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)
        let messageReference = MessageReference(messageCategory: .payment, serviceID: abortServiceID, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)
        let abortRequest = AbortRequest(messageReference: messageReference, abortReason: "MerchantAbort")
        let request = AdyenTerminalRequest<AbortRequest>(saleToPOIRequest: SaleToPOIRequest(messageHeader: messageHeader, request: abortRequest))

        let api = AdyenTerminalAPI(terminal: self)
        try await api.performResponseless(request: request)
    }

    public func reversal(serviceID: String, originalTransaction: TransactionIDType) async throws -> ReversalResponse {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .reversal, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)

        let reversalRequest = ReversalRequest(originalPOITransaction: OriginalPOITransaction(pOITransactionID: originalTransaction), reversalReason: .merchantCancel)
        let request = AdyenTerminalRequest<ReversalRequest>(saleToPOIRequest: SaleToPOIRequest(messageHeader: messageHeader, request: reversalRequest))

        let api = AdyenTerminalAPI(terminal: self)
        let terminalResponse: AdyenTerminalResponse<ReversalResponse> = try await api.perform(request: request)
        
        let response = terminalResponse.saleToPOIResponse.response.response

        guard response.result == .success else {
            if let condition = response.errorCondition {
                throw AdyenTerminalAPIError.adyen(error: condition.rawValue)
            } else {
                throw AdyenTerminalAPIError.unknown(error: "Unknown error condition")
            }
        }
        
        return terminalResponse.saleToPOIResponse.response
    }

    public func login(serviceID: String, operatorID: String) async throws {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .login, messageType: .request, serviceID: serviceID, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)

        let saleSoftware = SaleSoftware(manufacturerID: .goatgroup, applicationName: "FC-POS", softwareVersion: "1.2", certificationCode: "")
        let saleTerminalData = SaleTerminalData(totalsGroupID: self.location)
        let loginRequest = LoginRequest(dateTime: Date(), saleSoftware: saleSoftware, saleTerminalData: saleTerminalData, operatorLanguage: .english, operatorID: operatorID)
        
        let request = AdyenTerminalRequest<LoginRequest>(saleToPOIRequest: SaleToPOIRequest(messageHeader: messageHeader, request: loginRequest))

        let api = AdyenTerminalAPI(terminal: self)
        let terminalResponse: AdyenTerminalResponse<LoginResponse> = try await api.perform(request: request)

        let response = terminalResponse.saleToPOIResponse.response.response

        guard response.result == .success else {
            if let condition = response.errorCondition {
                throw AdyenTerminalAPIError.adyen(error: condition.rawValue)
            } else {
                throw AdyenTerminalAPIError.unknown(error: "Unknown error condition")
            }
        }
    }

    public func getTotals() async throws {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .getTotals, messageType: .request, serviceID: UUID().description.suffix(10).description, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)

        let getTotalsRequest = GetTotalsRequest()
        
        let request = AdyenTerminalRequest<GetTotalsRequest>(saleToPOIRequest: SaleToPOIRequest(messageHeader: messageHeader, request: getTotalsRequest))

        let api = AdyenTerminalAPI(terminal: self)
        let terminalResponse: AdyenTerminalResponse<GetTotalsResponse> = try await api.perform(request: request)

        let response = terminalResponse.saleToPOIResponse.response.response

        guard response.result == .success else {
            if let condition = response.errorCondition {
                throw AdyenTerminalAPIError.adyen(error: condition.rawValue)
            } else {
                throw AdyenTerminalAPIError.unknown(error: "Unknown error condition")
            }
        }
    }
}

