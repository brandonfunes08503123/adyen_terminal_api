//
//  SaleToPOIMessageSecured.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SaleToPOIMessageSecured: Codable {
    let messageHeader: MessageHeader
    let nexoBlob: String
    let securityTrailer: SecurityTrailer
}
