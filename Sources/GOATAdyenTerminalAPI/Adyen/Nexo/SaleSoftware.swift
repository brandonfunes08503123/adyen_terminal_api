//
//  SaleSoftware.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SaleSoftware: Encodable {
    public let manufacturerID: ManufacturerID
    public let applicationName: String
    public let softwareVersion: String
    public let certificationCode: String
}
