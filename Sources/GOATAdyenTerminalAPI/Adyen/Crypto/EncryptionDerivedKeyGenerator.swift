//
//  EncryptionDerivedKeyGenerator.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation
import CryptoSwift

public typealias ByteArray = Array<UInt8>

class EncryptionDerivedKeyGenerator {
    private let iterations = 4000
    private let salt = "AdyenNexoV1Salt"

    internal func generate(encryptionCredentialDetails: EncryptionCredentialDetails) throws -> EncryptionDerivedKey {
        let keyLength = EncryptionDerivedKey.hmacKeyLength + EncryptionDerivedKey.cipherKeyLength + EncryptionDerivedKey.ivLength

        let key = try PKCS5.PBKDF2(password: encryptionCredentialDetails.password.asciiBytes,
                                   salt: salt.asciiBytes,
                                   iterations: iterations,
                                   keyLength: keyLength,
                                   variant: .sha1).calculate()

        let hmacKey = Array(key[0..<EncryptionDerivedKey.hmacKeyLength])
        let cipherKey = Array(key[EncryptionDerivedKey.hmacKeyLength..<EncryptionDerivedKey.hmacKeyLength + EncryptionDerivedKey.cipherKeyLength])
        let iv = Array(key[EncryptionDerivedKey.hmacKeyLength + EncryptionDerivedKey.cipherKeyLength..<keyLength])

        return EncryptionDerivedKey(hmacKey: hmacKey, cipherKey: cipherKey, iv: iv)
    }
}
