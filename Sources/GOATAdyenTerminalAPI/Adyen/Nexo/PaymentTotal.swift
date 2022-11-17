//
//  PaymentTotal.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct PaymentTotal: Decodable {
    let transactionType: TransactionType
    let transactionCount: Int
    let transactionAmount: Float
}
