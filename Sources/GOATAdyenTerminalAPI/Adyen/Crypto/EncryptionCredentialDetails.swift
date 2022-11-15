//
//  EncryptionCredentialDetails.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct EncryptionCredentialDetails {
    let password: String
    let keyVersion: Int
    let keyIdentifier: String
    let adyenCryptoVersion: Int
}
