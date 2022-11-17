//
//  AdyenTerminalResponse.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct AdyenTerminalResponse<R:TerminalResponse>: Decodable {
    let saleToPOIResponse: SaleToPOIResponse<R>
}
