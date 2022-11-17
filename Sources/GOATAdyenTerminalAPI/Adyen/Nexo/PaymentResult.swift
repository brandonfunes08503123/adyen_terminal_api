//
//  PaymentResult.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct PaymentResult: Decodable {
    public let amountsResp: SimpleAmount?
    public let paymentInstrumentData: PaymentInstrumentData?
}
