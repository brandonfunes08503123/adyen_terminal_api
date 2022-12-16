//
//  RepeatedResponseMessageBody.swift
//  
//
//  Created by Javier Lanatta on 16/12/2022.
//

import Foundation

public struct RepeatedResponseMessageBody: Decodable {
//    public let loyaltyResponse: LoyaltyResponse
    public let paymentResponse: PaymentResponse?
    public let reversalResponse: ReversalResponse?
//    public let storedValueResponse: StoredValueResponse
//    public let cardAcquisitionResponse: CardAcquisitionResponse
//    public let cardReaderAPDUResponse: CardReaderAPDUResponse
}
