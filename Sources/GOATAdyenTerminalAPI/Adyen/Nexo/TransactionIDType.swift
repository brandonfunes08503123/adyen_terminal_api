//
//  TransactionIDType.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct TransactionIDType: Codable, Equatable, Hashable {
    public let transactionID: String
    public let timeStamp: Date
    
    public init(transactionID: String, timeStamp: Date) {
        self.transactionID = transactionID
        self.timeStamp = timeStamp
    }
}
