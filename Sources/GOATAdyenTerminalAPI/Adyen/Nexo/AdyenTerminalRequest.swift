//
//  AdyenPaymentRequest.swift
//  Meh
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation

public struct AdyenTerminalRequest<T:TerminalRequest>: Encodable {
    public let saleToPOIRequest: SaleToPOIRequest<T>
}
