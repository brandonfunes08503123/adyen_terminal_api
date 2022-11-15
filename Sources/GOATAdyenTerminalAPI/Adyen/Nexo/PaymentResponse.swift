//
//  PaymentResponse.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/27/22.
//

import Foundation

class PaymentResponse: TerminalResponse {
    let saleData: SaleData
    let paymentResult: PaymentResult?

    enum CodingKeys: CodingKey {
        case saleData
        case paymentResult
    }

    init(response: Response, saleData: SaleData, paymentResult: PaymentResult, pOIData: POIData) {
        self.saleData = saleData
        self.paymentResult = paymentResult
        super.init(response: response, pOIData: pOIData)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        saleData = try values.decode(SaleData.self, forKey: .saleData)
        paymentResult = try values.decodeIfPresent(PaymentResult.self, forKey: .paymentResult)
        try super.init(from: decoder)
    }    
}
