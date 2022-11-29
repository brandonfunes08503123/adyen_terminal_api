//
//  EncryptionCredentialDetails.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct EncryptionCredentialDetails {
    public let password: String
    public let keyVersion: Int
    public let keyIdentifier: String
    public let adyenCryptoVersion: Int
    
    public init(password: String, keyVersion: Int, keyIdentifier: String, adyenCryptoVersion: Int) {
        self.password = password
        self.keyVersion = keyVersion
        self.keyIdentifier = keyIdentifier
        self.adyenCryptoVersion = adyenCryptoVersion
    }
}
