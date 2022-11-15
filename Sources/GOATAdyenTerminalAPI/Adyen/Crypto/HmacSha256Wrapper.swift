//
//  HmacSha256Wrapper.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation
import CommonCrypto

class HmacSha256Wrapper {
    func hMac(bytesToHMac: ByteArray, hmacKey: ByteArray) -> ByteArray {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), hmacKey, EncryptionDerivedKey.hmacKeyLength, bytesToHMac, bytesToHMac.count, &digest)
        return digest
    }
}
