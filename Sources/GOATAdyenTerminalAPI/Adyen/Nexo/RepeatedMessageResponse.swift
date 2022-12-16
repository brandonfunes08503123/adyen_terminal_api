//
//  RepeatedMessageResponse.swift
//  
//
//  Created by Javier Lanatta on 16/12/2022.
//

import Foundation

public struct RepeatedMessageResponse: Decodable {
    public let messageHeader: MessageHeader
    public let repeatedResponseMessageBody: RepeatedResponseMessageBody
}
