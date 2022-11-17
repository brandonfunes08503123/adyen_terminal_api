//
//  SimpleAmount.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SimpleAmount: Decodable {
    public let authorizedAmount: Float
    public let currency: String
}
