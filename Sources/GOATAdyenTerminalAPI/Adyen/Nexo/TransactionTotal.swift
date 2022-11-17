//
//  TransactionTotal.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct TransactionTotal: Decodable {
    public let saleID: String
    public let paymentInstrumentType: PaymentInstrumentType
    public let paymentCurrency: String
    public let paymentTotals: [PaymentTotal]
}
