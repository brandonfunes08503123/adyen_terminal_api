//
//  TransactionStatusResponse.swift
//  
//
//  Created by Javier Lanatta on 16/12/2022.
//

import Foundation

public class TransactionStatusResponse: TerminalResponse {
    public let messageReference: MessageReference?
    
    enum CodingKeys: CodingKey {
        case messageReference
    }

    init(response: Response, pOIData: POIData, messageReference: MessageReference) {
        self.messageReference = messageReference
        super.init(response: response, pOIData: pOIData)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        messageReference = try values.decodeIfPresent(MessageReference.self, forKey: .messageReference)
        try super.init(from: decoder)
    }
}

