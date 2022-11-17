//
//  ReversalRequest.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public class ReversalRequest: TerminalRequest {
    let originalPOITransaction: OriginalPOITransaction
    let reversalReason: ReversalReason
    
    enum CodingKeys: String, CodingKey {
        case originalPOITransaction
        case reversalReason
    }

    init(originalPOITransaction: OriginalPOITransaction, reversalReason: ReversalReason) {
        self.originalPOITransaction = originalPOITransaction
        self.reversalReason = reversalReason
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(originalPOITransaction, forKey: .originalPOITransaction)
        try container.encode(reversalReason, forKey: .reversalReason)
    }
}
