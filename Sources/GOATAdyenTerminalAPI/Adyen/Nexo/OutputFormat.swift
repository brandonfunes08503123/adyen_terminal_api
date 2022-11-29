//
//  OutputFormat.swift
//  
//
//  Created by Javier Lanatta on 29/11/2022.
//

import Foundation

public enum OutputFormat: String, Decodable {
    case messageRef = "MessageRef"
    case text = "Text"
    case xhtml = "XHTML"
    case barCode = "BarCode"
}
