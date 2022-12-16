//
//  TransactionStatusResponse.swift
//  
//
//  Created by Javier Lanatta on 16/12/2022.
//

import Foundation

public class TransactionStatusResponse: TerminalResponse {
    public let messageReference: MessageReference?
    public let repeatedMessageResponse: RepeatedMessageResponse
    
    enum CodingKeys: CodingKey {
        case messageReference
        case repeatedMessageResponse
    }

    init(response: Response, pOIData: POIData, messageReference: MessageReference, repeatedMessageResponse: RepeatedMessageResponse) {
        self.messageReference = messageReference
        self.repeatedMessageResponse = repeatedMessageResponse
        super.init(response: response, pOIData: pOIData)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        messageReference = try values.decodeIfPresent(MessageReference.self, forKey: .messageReference)
        repeatedMessageResponse = try values.decode(RepeatedMessageResponse.self, forKey: .repeatedMessageResponse)
        try super.init(from: decoder)
    }
}

