//
//  AbortRequest.swift
//  
//
//  Created by Javier Lanatta on 14/12/2022.
//

import Foundation


public struct MessageReference: Codable {
    public let messageCategory: MessageCategory
    public let serviceID: String?
    public let deviceID: String?
    public let saleID: String?
    public let pOIID: String?
}
                
public class AbortRequest: TerminalRequest {
    let messageReference: MessageReference
    let abortReason: String
    
    enum CodingKeys: String, CodingKey {
        case messageReference
        case abortReason
    }

    public init(messageReference: MessageReference, abortReason: String) {
        self.messageReference = messageReference
        self.abortReason = abortReason
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(messageReference, forKey: .messageReference)
        try container.encode(abortReason, forKey: .abortReason)
    }
}
