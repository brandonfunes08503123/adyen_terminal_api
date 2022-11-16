//
//  AdyenTerminal.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

/// A representation of the hardware payment device. It allows to perform all the actions we need from the device: payments, refunds, etc.
struct AdyenTerminal {
    let ip: String
    let name: String
    let location: String
    let number: Int
    let poiId: String

    /// Perform a payment request on the hardware terminal.
    ///
    /// - Parameter serviceID: Your unique ID for this request, consisting of 1-10 alphanumeric characters. Must be unique within the last 48 hours for the terminal (POIID) being used.
    /// - Parameter currency: The transaction currency ISO code
    /// - Parameter amountCents: The final transaction amount expressed in cents.
    ///
    /// - Returns: The result of the payment
    ///
    func pay(transactionID: String, currency: String, amountCents: Int) async throws -> PaymentResponse {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .payment, messageType: .request, serviceID: UUID().description.suffix(10).description, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)
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
    
    func reversal(originalTransaction: TransactionIDType) async throws -> ReversalResponse {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .reversal, messageType: .request, serviceID: UUID().description.suffix(10).description, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)

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

    func login() async throws {
        let messageHeader = MessageHeader(protocolVersion: "3.0", messageClass: .service, messageCategory: .login, messageType: .request, serviceID: UUID().description.suffix(10).description, deviceID: nil, saleID: "POS_\(location)_\(number)", pOIID: poiId)

        let saleSoftware = SaleSoftware(manufacturerID: .goatgroup, applicationName: "FC-POS", softwareVersion: "1.2", certificationCode: "")
        let saleTerminalData = SaleTerminalData(totalsGroupID: self.location)
        let loginRequest = LoginRequest(dateTime: Date(), saleSoftware: saleSoftware, saleTerminalData: saleTerminalData, operatorLanguage: .english, operatorID: "javier.lanatta@flightclub.com")
        
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

    func getTotals() async throws {
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

