//
//  TransactionStatusRequest.swift
//  
//
//  Created by Javier Lanatta on 16/12/2022.
//

import Foundation

public class TransactionStatusRequest: TerminalRequest {
    public let messageReference: MessageReference
    public let receiptReprintFlag: Bool
    public let documentQualifier: [DocumentQualifier]

    enum CodingKeys: String, CodingKey {
        case messageReference
        case receiptReprintFlag
        case documentQualifier
    }

    public init(messageReference: MessageReference, receiptReprintFlag: Bool, documentQualifier: [DocumentQualifier]) {
        self.messageReference = messageReference
        self.receiptReprintFlag = receiptReprintFlag
        self.documentQualifier = documentQualifier
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(messageReference, forKey: .messageReference)
        try container.encode(receiptReprintFlag, forKey: .receiptReprintFlag)
        try container.encode(documentQualifier, forKey: .documentQualifier)
    }
}
