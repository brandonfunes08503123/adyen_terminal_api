//
//  TransactionIDType.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct TransactionIDType: Codable, Equatable, Hashable {
    let transactionID: String
    let timeStamp: Date
}
