//
//  SaleSoftware.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SaleSoftware: Encodable {
    public let manufacturerID: String
    public let applicationName: String
    public let softwareVersion: String
    public let certificationCode: String
    
    public init(manufacturerID: String, applicationName: String, softwareVersion: String, certificationCode: String) {
        self.manufacturerID = manufacturerID
        self.applicationName = applicationName
        self.softwareVersion = softwareVersion
        self.certificationCode = certificationCode
    }
}
