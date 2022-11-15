//
//  EncryptionDerivedKey.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation

struct EncryptionDerivedKey {
    static let hmacKeyLength = 32;
    static let cipherKeyLength = 32;
    static let ivLength = 16;

    internal let hmacKey: ByteArray
    internal let cipherKey: ByteArray
    internal let iv: ByteArray
}
