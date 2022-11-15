//
//  IVModGenerator.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 7/25/22.
//

import Foundation

class IVModGenerator {
    func generateRandomMod() -> ByteArray {
        var ivMod = ByteArray(repeating: 0, count: EncryptionDerivedKey.ivLength)
        for (index, _) in ivMod.enumerated() {
            ivMod[index] = UInt8.random(in: UInt8.min..<UInt8.max)
        }
        return ivMod
    }
}
