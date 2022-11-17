//
//  AmountsReq.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

///
/// https://docs.adyen.com/point-of-sale/terminal-api/terminal-api-reference#comadyennexoamountsreq
///
public struct AmountsReq: Codable {
    let currency: String
    let requestedAmount: Float
}
