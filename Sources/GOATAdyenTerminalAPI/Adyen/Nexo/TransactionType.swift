//
//  TransactionType.swift
//  GOATGROUP - Adyen TerminalAPI Implementation
//
//  Created by Javier Lanatta on 11/11/2022.
//

import Foundation

enum TransactionType: String, Decodable {
    case debit = "Debit"
    case credit = "Credit"
    case reverseDebit = "ReverseDebit"
    case reverseCredit = "ReverseCredit"
    case oneTimeReservation = "OneTimeReservation"
    case completedDeffered = "CompletedDeffered"
    case firstReservation = "FirstReservation"
    case updateReservation = "UpdateReservation"
    case completedReservation = "CompletedReservation"
    case cashAdvance = "CashAdvance"
    case issuerInstalment = "IssuerInstalment"
    case declined = "Declined"
    case failed = "Failed"
    case award = "Award"
    case reverseAward = "ReverseAward"
    case redemption = "Redemption"
    case reverseRedemption = "ReverseRedemption"
    case rebate = "Rebate"
    case reverseRebate = "ReverseRebate"
}
