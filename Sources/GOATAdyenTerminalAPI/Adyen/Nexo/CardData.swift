//
//  CardData.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

struct CardData: Decodable {
    let maskedPan: String?
    let paymentBrand: String?
    let cardCountryCode: String?

}
