//
//  PaymentReceipt.swift
//  
//
//  Created by Javier Lanatta on 29/11/2022.
//

import Foundation

public struct PaymentReceipt: Decodable {
    public let documentQualifier: DocumentQualifier
    public let outputContent: OutputContent
}
