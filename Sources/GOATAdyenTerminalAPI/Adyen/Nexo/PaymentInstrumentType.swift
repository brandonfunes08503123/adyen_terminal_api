//
//  PaymentInstrumentType.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public enum PaymentInstrumentType: String, Decodable {
    case card = "Card"
    case check = "Check"
    case mobile = "Mobile"
    case storedValue = "StoredValue"
    case cash = "Cash"
}
