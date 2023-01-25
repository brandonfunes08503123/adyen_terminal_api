//
//  PaymentAcquirerData.swift
//  
//
//  Created by Javier Lanatta on 25/01/2023.
//

import Foundation

public struct PaymentAcquirerData: Decodable {
    public let acquirerPOIID: String?
    public let approvalCode: String?
    public let acquirerTransactionID: TransactionIDType?
    public let merchantID: String?
}
