//
//  CardData.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct CardData: Decodable {
    public let maskedPan: String?
    public let paymentBrand: String?
    public let cardCountryCode: String?
}
