//
//  Tela1ViewController.swift
//  CocoaPodTests
//
//  Created by douglaswilliamn on 10/09/21.
//  Copyright © 2021 CESAR School. All rights reserved.
//

import UIKit
import Alamofire

class Tela1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AF.request("https://carangas.herokuapp.com/cars").response { response in
            debugPrint(response)
        }
        
        AF.request("https://carangas.herokuapp.com/cars").responseJSON { response in
            debugPrint(response)
        }
    }
}
