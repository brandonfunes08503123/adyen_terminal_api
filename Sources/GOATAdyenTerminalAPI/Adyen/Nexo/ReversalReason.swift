//
//  ReversalReason.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public enum ReversalReason: String, Encodable {
    case customerCancel = "CustCancel"
    case merchantCancel = "MerchantCancel"
    case malfunction = "Malfunction"
    case unableToComplete = "Unable2Compl"
}
