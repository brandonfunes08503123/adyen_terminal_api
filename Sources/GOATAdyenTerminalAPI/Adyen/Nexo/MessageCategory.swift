//
//  MessageCategory.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

enum MessageCategory: String, Codable {
    case payment = "Payment"
    case getTotals = "GetTotals"
    case login = "Login"
    case reversal = "Reversal"
}
