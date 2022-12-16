//
//  TransactionStatusResponse.swift
//  
//
//  Created by Javier Lanatta on 16/12/2022.
//

import Foundation

public class TransactionStatusResponse: TerminalResponse {
    public let messageReference: MessageReference?
    public let repeatedResponseMessageBody: RepeatedResponseMessageBody
    
    enum CodingKeys: CodingKey {
        case messageReference
        case repeatedResponseMessageBody
    }

    init(response: Response, pOIData: POIData, messageReference: MessageReference, repeatedResponseMessageBody: RepeatedResponseMessageBody) {
        self.messageReference = messageReference
        self.repeatedResponseMessageBody = repeatedResponseMessageBody
        super.init(response: response, pOIData: pOIData)
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        messageReference = try values.decodeIfPresent(MessageReference.self, forKey: .messageReference)
        repeatedResponseMessageBody = try values.decode(RepeatedResponseMessageBody.self, forKey: .repeatedResponseMessageBody)
        try super.init(from: decoder)
    }
}

