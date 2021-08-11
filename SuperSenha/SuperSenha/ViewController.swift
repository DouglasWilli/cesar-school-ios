//
//  ViewController.swift
//  SuperSenha
//
//  Created by Douglas Williamn on 11/08/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    @IBOutlet weak var swCaptitalLetters: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! PasswordViewController
        
        if let numberOfPasswords = Int(tfTotalPasswords.text!) {
            vc.numberOfPasswords = numberOfPasswords
        }
        if let numberOfCharacters = Int(tfNumberOfCharacters.text!) {
            vc.numberOfCharacters = numberOfCharacters
        }
        vc.useNumbers = swNumbers.isOn
        vc.useCapitalLetters = swCaptitalLetters.isOn
        vc.useLetters = swLetters.isOn
        vc.useSpecialCharacters = swSpecialCharacters.isOn
        
        view.endEditing(true)
    }
}
