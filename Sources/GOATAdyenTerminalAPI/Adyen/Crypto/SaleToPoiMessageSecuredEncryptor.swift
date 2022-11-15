//
//  SaleToPOIMessageSecuredEncryptor.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation
import CommonCrypto

class SaleToPOIMessageSecuredEncryptor {
    let encryptionDerivedKeyGenerator: EncryptionDerivedKeyGenerator
    let aesEncryptor: AESEncryptor
    let hmacSha256Wrapper: HmacSha256Wrapper
    let ivModGenerator: IVModGenerator

    init() {
        self.encryptionDerivedKeyGenerator = EncryptionDerivedKeyGenerator()
        self.aesEncryptor = AESEncryptor()
        self.hmacSha256Wrapper = HmacSha256Wrapper()
        self.ivModGenerator = IVModGenerator()
    }

    func encrypt(saleToPOIMessage: String, messageHeader: MessageHeader, encryptionCredentialDetails: EncryptionCredentialDetails) throws -> SaleToPOIMessageSecured {
        let encryptionDerivedKey = try encryptionDerivedKeyGenerator.generate(encryptionCredentialDetails: encryptionCredentialDetails)
        let saleToPOIMessageJson = saleToPOIMessage;
        let saleToPOIMessageByteArray = saleToPOIMessageJson.bytes
        let ivMod = ivModGenerator.generateRandomMod()
        let saleToPOIMessageAesEncrypted = try aesEncryptor.encrypt(byteArrayToEncrypt: saleToPOIMessageByteArray,
                                                                    encryptionDerivedKey: encryptionDerivedKey,
                                                                    ivMod: ivMod)
        let saleToPOIMessageAesEncryptedHmac = hmacSha256Wrapper.hMac(bytesToHMac: saleToPOIMessageByteArray,
                                                                      hmacKey: encryptionDerivedKey.hmacKey)
        
        let securityTrailer = SecurityTrailer(adyenCryptoVersion: encryptionCredentialDetails.adyenCryptoVersion,
                                              keyIdentifier: encryptionCredentialDetails.keyIdentifier,
                                              keyVersion: encryptionCredentialDetails.keyVersion,
                                              nonce: ivMod.toBase64(),
                                              hmac: saleToPOIMessageAesEncryptedHmac.toBase64())
        
        return SaleToPOIMessageSecured(messageHeader: messageHeader,
                                       nexoBlob: saleToPOIMessageAesEncrypted.toBase64(),
                                       securityTrailer: securityTrailer)
    }
    
    func descrypt(saleToPOIMessageSecured: SaleToPOIMessageSecured, encryptionCredentialDetails: EncryptionCredentialDetails) throws -> Data {
        let encryptedSaleToPOIMessageByteArray = ByteArray(base64: saleToPOIMessageSecured.nexoBlob)
        let encryptionDerivedKey = try encryptionDerivedKeyGenerator.generate(encryptionCredentialDetails: encryptionCredentialDetails)
        
        let nonce = Data(base64Encoded: saleToPOIMessageSecured.securityTrailer.nonce)!.bytes
        
        let decryptedSaleToPOIMessageByteArray = try aesEncryptor.decrypt(byteArrayToDecrypt: encryptedSaleToPOIMessageByteArray, encryptionDerivedKey: encryptionDerivedKey, ivMod: nonce)
        
        let receivedHmac = Data(base64Encoded: saleToPOIMessageSecured.securityTrailer.hmac)!.bytes
        
        try validateHmac(receivedHmac: receivedHmac, decryptedSaleToPOIMessageByteArray: decryptedSaleToPOIMessageByteArray, encryptionDerivedKey: encryptionDerivedKey)
        return Data(bytes: decryptedSaleToPOIMessageByteArray, count: decryptedSaleToPOIMessageByteArray.count)
    }
    
    private func validateHmac(receivedHmac: ByteArray, decryptedSaleToPOIMessageByteArray: ByteArray, encryptionDerivedKey: EncryptionDerivedKey) throws {
        let hmacSha256Wrapper = HmacSha256Wrapper()
        let hmac = hmacSha256Wrapper.hMac(bytesToHMac: decryptedSaleToPOIMessageByteArray, hmacKey: encryptionDerivedKey.hmacKey)

        guard receivedHmac.count == hmac.count else {
            throw AdyenCryptoError.hmac
        }

        try receivedHmac.indices.forEach { index in
            if receivedHmac[index] != hmac[index] {
                throw AdyenCryptoError.hmac
            }
        }
    }
}
