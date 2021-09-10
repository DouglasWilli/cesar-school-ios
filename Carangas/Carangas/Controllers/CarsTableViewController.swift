//
//  GamesTableViewController.swift
//  MyGames
//
//  Created by douglaswilliamn on 10/09/21.
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    var cars: [Car] = []
    
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "main")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Carregando carros ..."
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadCars), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCars()
    }
  
    @objc func loadCars() {
        REST.loadCars { cars in
            self.cars = cars
            
            // precisa recarregar a tableview usando a main UI thread
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            
        } onError: { error in
            var response: String = ""
            
            switch error {
            case .invalidJSON:
                response = "invalidJSON"
            case .noData:
                response = "noData"
            case .noResponse:
                response = "noResponse"
            case .url:
                response = "JSON inválido"
            case .taskError(let error):
                response = "\(error.localizedDescription)"
            case .responseStatusCode(let code):
                if code != 200 {
                    response = "Algum problema com o servidor. :( \nError:\(code)"
                }
            }
            
            print(response)
            
            DispatchQueue.main.async {
                self.label.text = "Ocorreu um erro no servidor\n\n\(response)"
                self.tableView.backgroundView = self.label
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = cars.count
        
        if count == 0 {
            // mostrar mensagem padrao
            self.label.text = "Sem dados"
            self.tableView.backgroundView = self.label
        } else {
            self.tableView.backgroundView = nil
        }
        
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let car = cars[indexPath.row]
            REST.delete(car: car) { (success) in
                if success {
                    
                    // ATENCAO nao esquecer disso
                    self.cars.remove(at: indexPath.row)
                    
                    DispatchQueue.main.async {
                        // Delete the row from the data source
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }else {
                    print("Nao foi possivel deletar do servidor esse carro.")
                }
            
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSegue" {
            
            let vc = segue.destination as! CarViewController
            if let row = tableView.indexPathForSelectedRow?.row {
                vc.car = cars[row]
            }
        }
    }
}
