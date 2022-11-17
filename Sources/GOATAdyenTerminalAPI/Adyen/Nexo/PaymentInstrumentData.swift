//
//  PaymentInstrumentData.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public struct PaymentInstrumentData: Decodable {
    public let cardData: CardData
}
