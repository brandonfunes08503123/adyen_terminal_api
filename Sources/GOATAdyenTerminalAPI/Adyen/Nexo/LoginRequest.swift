//
//  LoginRequest.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public class LoginRequest: TerminalRequest {
    public let dateTime: Date
    public let saleSoftware: SaleSoftware
    public let saleTerminalData: SaleTerminalData
    public let operatorLanguage: OperatorLanguage
    public let operatorID: String

    enum CodingKeys: String, CodingKey {
        case dateTime
        case saleSoftware
        case saleTerminalData
        case operatorLanguage
        case operatorID
    }
    
    init(dateTime: Date, saleSoftware: SaleSoftware, saleTerminalData: SaleTerminalData, operatorLanguage: OperatorLanguage, operatorID: String) {
        self.dateTime = dateTime
        self.saleSoftware = saleSoftware
        self.saleTerminalData = saleTerminalData
        self.operatorLanguage = operatorLanguage
        self.operatorID = operatorID
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(dateTime, forKey: .dateTime)
        try container.encode(saleSoftware, forKey: .saleSoftware)
        try container.encode(saleTerminalData, forKey: .saleTerminalData)
        try container.encode(operatorLanguage, forKey: .operatorLanguage)
        try container.encode(operatorID, forKey: .operatorID)
    }
}
