//
//  SaleToPOIMessageSecured.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SaleToPOIMessageSecured: Codable {
    public let messageHeader: MessageHeader
    public let nexoBlob: String
    public let securityTrailer: SecurityTrailer
}
