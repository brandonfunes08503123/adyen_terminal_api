//
//  PaymentTotal.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct PaymentTotal: Decodable {
    public let transactionType: TransactionType
    public let transactionCount: Int
    public let transactionAmount: Float
}
