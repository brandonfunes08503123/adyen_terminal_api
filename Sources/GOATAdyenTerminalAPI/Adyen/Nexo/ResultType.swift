//
//  ResultType.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

enum ResultType: String, Codable {
    case success = "Success"
    case failure = "Failure"
    case partial = "Partial"
}
