//
//  GamesTableViewController.swift
//  MyGames
//
//  Created by douglaswilliamn on 10/09/21.
//

import Foundation

class Car: Codable {
    
    var _id: String?
    var brand: String = "" // marca
    var gasType: Int = 0
    var name: String = ""
    var price: Double = 0.0
    
    var gas: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Álcool"
        default:
            return "Gasolina"
        }
    }
}
