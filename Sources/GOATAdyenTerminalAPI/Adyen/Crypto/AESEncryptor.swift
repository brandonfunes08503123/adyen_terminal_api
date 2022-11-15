//
//  AESEncryptor.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation
import CryptoSwift

class AESEncryptor {
    internal func encrypt(byteArrayToEncrypt: ByteArray, encryptionDerivedKey: EncryptionDerivedKey, ivMod: ByteArray) throws -> ByteArray {
        let iv = transformIV(originalIV: encryptionDerivedKey.iv, ivMod: ivMod)
        let aes = try AES(key: encryptionDerivedKey.cipherKey, blockMode: CBC(iv: iv), padding: .pkcs7)
        var encryptTransform = try aes.makeEncryptor()
        let byteArrayEncrypted = try encryptTransform.finish(withBytes: byteArrayToEncrypt)
        return byteArrayEncrypted
    }

    internal func decrypt(byteArrayToDecrypt: ByteArray, encryptionDerivedKey: EncryptionDerivedKey, ivMod: ByteArray) throws -> ByteArray {
        let iv = transformIV(originalIV: encryptionDerivedKey.iv, ivMod: ivMod)
        let aes = try AES(key: encryptionDerivedKey.cipherKey, blockMode: CBC(iv: iv), padding: .pkcs7)
        var decryptTransform = try aes.makeDecryptor()
        let byteArrayDecrypted = try decryptTransform.finish(withBytes: byteArrayToDecrypt)
        return byteArrayDecrypted
    }

    private func transformIV(originalIV: Array<UInt8>, ivMod: Array<UInt8>) -> Array<UInt8> {
        var updatedIV = Array<UInt8>(repeating: 0, count: EncryptionDerivedKey.ivLength)
        originalIV.indices.forEach { index in
            updatedIV[index] = originalIV[index] ^ ivMod[index]
        }
        return updatedIV
    }
}
