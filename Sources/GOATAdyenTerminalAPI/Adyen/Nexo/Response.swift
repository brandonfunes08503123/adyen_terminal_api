//
//  Response.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct Response: Codable {
    public var additionalResponse: String?
    public var result: ResultType
    public var errorCondition: ErrorConditionType?
    
    public var parsedAdditionalResponse: [String: String] {
        guard let additionalResponse = additionalResponse else { return [:] }

        var result: [String: String] = [:]
        additionalResponse.components(separatedBy: "&").forEach { (line: String) in
            let items = line.components(separatedBy: "=")
            result[items[0]] = items[1].removingPercentEncoding
        }

        return result
    }
}
