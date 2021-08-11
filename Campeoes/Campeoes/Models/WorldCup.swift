//
//  WorldCup.swift
//  Campeoes
//
//  Created by Douglas Williamn on 11/08/21.
//

import Foundation

struct WorldCup: Codable {
    
    let year: Int
    let country: String
    let winner: String
    let vice: String
    let winnerScore: String
    let viceScore: String
    let matches: [Match]
}
