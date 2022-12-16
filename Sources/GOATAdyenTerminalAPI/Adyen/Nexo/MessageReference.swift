//
//  MessageReference.swift
//  
//
//  Created by Javier Lanatta on 16/12/2022.
//

import Foundation

public struct MessageReference: Codable {
    public let messageCategory: MessageCategory
    public let serviceID: String?
    public let deviceID: String?
    public let saleID: String?
    public let pOIID: String?
}
