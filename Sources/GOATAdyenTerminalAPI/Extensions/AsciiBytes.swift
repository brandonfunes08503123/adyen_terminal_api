//
//  AsciiBytes.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

extension String {
    public var asciiBytes: ByteArray {
        guard let data = data(using: .ascii) else {
            fatalError()
        }
        return Array(data)
    }
}


