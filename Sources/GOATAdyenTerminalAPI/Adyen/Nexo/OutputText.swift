//
//  OutputText.swift
//  
//
//  Created by Javier Lanatta on 29/11/2022.
//

import Foundation

public struct OutputText: Decodable {
    public let text: String
    public let characterSet: Int?
    public let font: String?
    public let startRow: Int?
    public let startColumn: Int?
    public let color: AdyenColor?
    public let characterWidth: AdyenCharacterWidth?
    public let characterHeight: AdyenCharacterHeight?
    public let characterStyle: AdyenCharacterStyle?
    public let alignment: AdyenAlignment?
    public let endOfLineFlag: Bool?
}
