//
//  CreditCardTerminalAPIError.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

enum AdyenTerminalAPIError: LocalizedError {
    case adyen(error: String)
    case unknown(error: String)
    case serverCertificateUntrusted

    var errorDescription: String? {
        switch self {
        case .adyen(error: let error):
            return "Payment terminal response: \(error)"
        case .unknown(error: let error):
            return "Unknown error: \(error)"
        case .serverCertificateUntrusted:
            return "Payment device security certificate is untrusted."
        }
    }
}
