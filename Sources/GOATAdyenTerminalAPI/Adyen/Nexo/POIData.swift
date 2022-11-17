//
//  POIData.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct POIData: Codable {
    let pOITransactionID: TransactionIDType
    let pOIReconciliationID: String?
}
