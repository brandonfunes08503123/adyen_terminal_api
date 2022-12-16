//
//  ReversalResponse.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public class ReversalResponse: TerminalResponse {
    public let reversedAmount: SimpleAmount?
    public let paymentReceipt: [PaymentReceipt]

    enum CodingKeys: CodingKey {
        case reversedAmount
        case paymentReceipt
    }

    init(response: Response, reversedAmount: SimpleAmount, paymentReceipt: [PaymentReceipt], pOIData: POIData) {
        self.reversedAmount = reversedAmount
        self.paymentReceipt = paymentReceipt
        super.init(response: response, pOIData: pOIData)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reversedAmount = try values.decodeIfPresent(SimpleAmount.self, forKey: .reversedAmount)
        paymentReceipt = try values.decode([PaymentReceipt].self, forKey: .paymentReceipt)
        try super.init(from: decoder)
    }
}
