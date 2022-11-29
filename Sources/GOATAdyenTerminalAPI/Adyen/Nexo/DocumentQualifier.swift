//
//  DocumentQualifier.swift
//  
//
//  Created by Javier Lanatta on 29/11/2022.
//

import Foundation

public enum DocumentQualifier: String, Decodable {
    case saleReceipt = "SaleReceipt"
    case cashierReceipt = "CashierReceipt"
    case customerReceipt = "CustomerReceipt"
    case document = "Document"
    case voucher = "Voucher"
    case journal = "Journal"
}
