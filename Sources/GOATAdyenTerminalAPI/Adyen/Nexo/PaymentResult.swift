//
//  PaymentResult.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct PaymentResult: Decodable {
    let amountsResp: SimpleAmount?
    let paymentInstrumentData: PaymentInstrumentData?
}
