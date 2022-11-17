//
//  SecurityTrailer.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SecurityTrailer: Codable {
    public let adyenCryptoVersion: Int
    public let keyIdentifier: String
    public let keyVersion: Int
    public let nonce: String
    public let hmac: String
}
