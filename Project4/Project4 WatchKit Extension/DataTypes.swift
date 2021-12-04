//
//  DataTypes.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 12/3/21.
//

import Foundation

struct OERInfo : Codable {
    var API_KEY : String
}

struct CurrencyResult: Codable {
    let base: String
    let rates: [String: Double]
}
