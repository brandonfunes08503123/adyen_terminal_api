//
//  CreditCardTerminalAPIError.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public enum AdyenTerminalAPIError: LocalizedError {
    case adyen(error: String)
    case decoding(error: String)
    case unknown(error: String)
    case serverCertificateUntrusted

    public var errorDescription: String? {
        switch self {
        case .adyen(error: let error):
            return "Payment terminal response: \(error)"
        case .decoding:
            return "Error decoding server data."
        case .unknown(error: let error):
            return "Unknown error: \(error)"
        case .serverCertificateUntrusted:
            return "Payment device security certificate is untrusted."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .adyen(error: let error):
            return error
        case .decoding(error: let error):
            return error
        case .unknown(error: let error):
            return error
        case .serverCertificateUntrusted:
            return "Payment device security certificate is untrusted."
        }
    }

}
