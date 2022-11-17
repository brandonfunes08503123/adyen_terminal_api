//
//  ErrorConditionType.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

public public enum ErrorConditionType: String, Codable {
    case aborted = "Aborted"
    case busy = "Busy"
    case cancel = "Cancel"
    case deviceOut = "DeviceOut"
    case insertedCard = "InsertedCard"
    case inProgress = "InProgress"
    case loggedOut = "LoggedOut"
    case messageFormat = "MessageFormat"
    case notAllowed = "NotAllowed"
    case notFound = "NotFound"
    case paymentRestriction = "PaymentRestriction"
    case refusal = "Refusal"
    case unavailableDevice = "UnavailableDevice"
    case unavailableService = "UnavailableService"
    case invalidCard = "InvalidCard"
    case unreachableHost = "UnreachableHost"
    case wrongPIN = "WrongPIN"
}
