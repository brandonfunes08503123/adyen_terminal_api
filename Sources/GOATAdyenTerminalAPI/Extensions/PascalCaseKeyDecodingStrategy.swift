//
//  PascalCaseKeyDecodingStrategy.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation

///
/// Code inspired from this article:
/// https://github.com/eneko/Blog/issues/23
///

extension JSONDecoder.KeyDecodingStrategy {
    static var convertFromPascalCase: Self {
        .custom { codingPath in
            let key = codingPath.last!.stringValue
            let value = key.prefix(1).lowercased() + key.dropFirst()
            return AnyKey(stringValue: value)!
        }
    }
}

extension JSONEncoder.KeyEncodingStrategy {
    static var convertToPascalCase: Self {
        .custom { codingPath in
            let key = codingPath.last!.stringValue
            let value = key.prefix(1).uppercased() + key.dropFirst()
            return AnyKey(stringValue: value)!
        }
    }
}

/// Copied from Apple's official documentation for custom coding keys
/// https://developer.apple.com/documentation/foundation/jsondecoder/keydecodingstrategy/custom
struct AnyKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
