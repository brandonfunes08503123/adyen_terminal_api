//
//  CreditCardTerminalAPIError.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public enum AdyenTerminalAPIError: LocalizedError {
    case adyen(error: String, additionalResponse: [String:String])
    case decoding(error: String)
    case unknown(error: String)
    case serverCertificateUntrusted
    case cannotConnectToHost

    public var errorDescription: String? {
        switch self {
        case .adyen(error: let error, additionalResponse: _):
            return "Payment terminal response: \(error)"
        case .decoding:
            return "Error decoding server data."
        case .unknown(error: let error):
            return "Unknown error: \(error)"
        case .serverCertificateUntrusted:
            return "Payment device security certificate is untrusted."
        case .cannotConnectToHost:
            return "Cannot connect to the payment device."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .adyen(error: let error, additionalResponse: let additionalResponse):
            return additionalResponse["message"] ?? error
        case .decoding(error: let error):
            return error
        case .unknown(error: let error):
            return error
        default:
            return errorDescription
        }
    }

}
