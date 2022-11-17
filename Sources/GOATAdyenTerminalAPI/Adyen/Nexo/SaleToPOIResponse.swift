//
//  SaleToPOIResponse.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct SaleToPOIResponse<R:TerminalResponse>: Decodable {
    let messageHeader: MessageHeader
    let response: R
    
    enum CodingKeys: CodingKey {
        case messageHeader
        case paymentResponse
        case getTotalsResponse
        case loginResponse
        case reversalResponse
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let allKeys = Set(values.allKeys)
        let responseKeys = Set([CodingKeys.paymentResponse, CodingKeys.getTotalsResponse, CodingKeys.loginResponse, CodingKeys.reversalResponse])
        guard let responseKey = allKeys.intersection(responseKeys).first else { fatalError("SaleToPOIResponse: Response decoding key not found") }
        
        messageHeader = try values.decode(MessageHeader.self, forKey: .messageHeader)
        response = try values.decode(R.self, forKey: responseKey)
    }
}
