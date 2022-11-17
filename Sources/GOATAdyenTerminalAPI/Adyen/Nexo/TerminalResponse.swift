//
//  TerminalResponse.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public class TerminalResponse: Decodable {
    public let response: Response
    public let pOIData: POIData?

    init(response: Response, pOIData: POIData) {
        self.response = response
        self.pOIData = pOIData
    }
    
    enum CodingKeys: CodingKey {
        case response
        case pOIData
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decode(Response.self, forKey: .response)
        self.pOIData = try container.decodeIfPresent(POIData.self, forKey: .pOIData)
    }
}
