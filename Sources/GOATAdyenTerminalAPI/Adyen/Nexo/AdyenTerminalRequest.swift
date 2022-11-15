//
//  AdyenPaymentRequest.swift
//  Meh
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation

struct AdyenTerminalRequest<T:TerminalRequest>: Encodable {
    let saleToPOIRequest: SaleToPOIRequest<T>
}

