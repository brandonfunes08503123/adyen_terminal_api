//
//  SecurityTrailer.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct SecurityTrailer: Codable {
    let adyenCryptoVersion: Int
    let keyIdentifier: String
    let keyVersion: Int
    let nonce: String
    let hmac: String
}
