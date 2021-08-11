//
//  CountryDetailViewController.swift
//  Campeoes
//
//  Created by Douglas Williamn on 11/08/21.
//

import UIKit

class CountryDetailViewController: UIViewController {

    var worldCups: [WorldCup]!
    var winner: String!
    
    @IBOutlet weak var ivWinner: UIImageView!
    @IBOutlet weak var lbCopas: UILabel!
    
    @IBOutlet weak var lbCountry: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    
    @IBOutlet weak var lbVice: UILabel!
    @IBOutlet weak var lbViceScore: UILabel!
    @IBOutlet weak var lbWinnerScore: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var vitoriasAcumuladas : Int = 0
        var dadosConquistas = ""
        
        for worldCup in worldCups {
            if winner == worldCup.winner {
                vitoriasAcumuladas += 1
                dadosConquistas += "País: \(worldCup.country), \(worldCup.year) ( \(worldCup.vice) \(worldCup.viceScore) x \(worldCup.winnerScore) \(worldCup.winner) )"
                ivWinner.image = UIImage(named: worldCup.winner)
                lbCopas.text = "\(vitoriasAcumuladas)"
                
                lbCountry.text = worldCup.country
                lbYear.text = worldCup.year.description
                lbVice.text = worldCup.vice
                lbViceScore.text = worldCup.viceScore
                lbWinnerScore.text = worldCup.winnerScore
                lbScore.text = worldCup.winner
            }
        }
        
        print("Vitórias: \(vitoriasAcumuladas)")
        print("Conquistas: \(dadosConquistas)")
    }
}
