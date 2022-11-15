//
//  Response.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct Response: Codable {
    public var additionalResponse: String?
    public var result: ResultType
    public var errorCondition: ErrorConditionType?
}
