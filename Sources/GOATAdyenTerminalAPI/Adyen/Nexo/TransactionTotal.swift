//
//  TransactionTotal.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct TransactionTotal: Decodable {
    let saleID: String
    let paymentInstrumentType: PaymentInstrumentType
    let paymentCurrency: String
    let paymentTotals: [PaymentTotal]
}
