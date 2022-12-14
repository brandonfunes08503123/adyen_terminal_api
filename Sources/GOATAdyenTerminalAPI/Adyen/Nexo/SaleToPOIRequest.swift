//
//  SaleToPOIRequest.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SaleToPOIRequest<T:TerminalRequest>: Encodable {
    public let messageHeader: MessageHeader
    public let request: T
    
    enum CodingKeys: CodingKey {
        case messageHeader
        case paymentRequest
        case getTotalsRequest
        case loginRequest
        case reversalRequest
        case abortRequest
    }
    
    public func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<SaleToPOIRequest<T>.CodingKeys> = encoder.container(keyedBy: SaleToPOIRequest<T>.CodingKeys.self)
        try container.encode(self.messageHeader, forKey: SaleToPOIRequest<T>.CodingKeys.messageHeader)
        try container.encode(self.request, forKey: self.requestCodingKey)
    }
    
    var requestCodingKey: CodingKeys {
        switch request {
        case is PaymentRequest:
            return .paymentRequest
        case is LoginRequest:
            return .loginRequest
        case is GetTotalsRequest:
            return .getTotalsRequest
        case is ReversalRequest:
            return .reversalRequest
        case is AbortRequest:
            return .abortRequest
        default:
            fatalError("Missing key for request of type: \(request.self)")
        }
    }
}
