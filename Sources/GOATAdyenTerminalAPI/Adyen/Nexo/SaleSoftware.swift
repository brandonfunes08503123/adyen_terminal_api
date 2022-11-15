//
//  SaleSoftware.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct SaleSoftware: Encodable {
    let manufacturerID: ManufacturerID
    let applicationName: String
    let softwareVersion: String
    let certificationCode: String
}
