//
//  GetTotalsResponse.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public class GetTotalsResponse: TerminalResponse {
    let pOIReconciliationID: String
    let transactionTotals: [TransactionTotal]

    enum CodingKeys: CodingKey {
        case pOIReconciliationID
        case transactionTotals
    }

    init(response: Response, pOIReconciliationID: String, transactionTotals: [TransactionTotal], pOIData: POIData) {
        self.pOIReconciliationID = pOIReconciliationID
        self.transactionTotals = transactionTotals
        super.init(response: response, pOIData: pOIData)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pOIReconciliationID = try values.decode(String.self, forKey: .pOIReconciliationID)
        transactionTotals = try values.decode([TransactionTotal].self, forKey: .transactionTotals)
        try super.init(from: decoder)
    }
}

