//
//  CountriesTableViewController.swift
//  Campeoes
//
//  Created by Douglas Williamn on 11/08/21.
//

import UIKit

class CountriesTableViewController: UITableViewController {

    var worldCups: [WorldCup] = []
    var worldCupWinners: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWorldCups()
    }
    
    func loadWorldCups() {
        let fileURL = Bundle.main.url(forResource: "winners", withExtension: ".json")!
        let jsonData = try! Data(contentsOf: fileURL)
        
        do {
            worldCups = try JSONDecoder().decode([WorldCup].self, from: jsonData)
            
            for worldCup in worldCups {
                worldCupWinners.append(worldCup.winner)
            }
                       
            worldCupWinners = unique(source: worldCupWinners)
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    func unique<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldCupWinners.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
        let worldCupWinner = worldCupWinners[indexPath.row]
        
        cell.textLabel?.text = worldCupWinner
        cell.imageView?.image = UIImage(named: worldCupWinner)

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let worldCup = worldCups[tableView.indexPathForSelectedRow!.row]
                
        let vc = segue.destination as? CountryDetailViewController
        vc?.worldCups = worldCups
        vc?.winner = worldCup.winner
    }
}
