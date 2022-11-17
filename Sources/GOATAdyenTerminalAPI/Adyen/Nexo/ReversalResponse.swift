//
//  ReversalResponse.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public class ReversalResponse: TerminalResponse {
    let reversedAmount: SimpleAmount

    enum CodingKeys: CodingKey {
        case reversedAmount
    }

    init(response: Response, reversedAmount: SimpleAmount, pOIData: POIData) {
        self.reversedAmount = reversedAmount
        super.init(response: response, pOIData: pOIData)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reversedAmount = try values.decode(SimpleAmount.self, forKey: .reversedAmount)
        try super.init(from: decoder)
    }
}
