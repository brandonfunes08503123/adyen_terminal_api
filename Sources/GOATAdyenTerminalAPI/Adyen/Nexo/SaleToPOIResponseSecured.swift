//
//  SaleToPOIResponseSecured.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SaleToPOIResponseSecured: Decodable {
    public let saleToPOIResponse: SaleToPOIMessageSecured
}
