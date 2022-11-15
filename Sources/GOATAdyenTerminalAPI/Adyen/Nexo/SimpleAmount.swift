//
//  SimpleAmount.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct SimpleAmount: Decodable {
    let authorizedAmount: Float
    let currency: String
}
