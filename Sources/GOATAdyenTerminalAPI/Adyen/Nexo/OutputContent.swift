//
//  OutputContent.swift
//  
//
//  Created by Javier Lanatta on 29/11/2022.
//

import Foundation

public struct OutputContent: Decodable {
    public let outputFormat: OutputFormat
    public let outputText: [OutputText]
}
