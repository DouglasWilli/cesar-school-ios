//
//  PasswordViewController.swift
//  SuperSenha
//
//  Created by Douglas Williamn on 11/08/21.
//

import UIKit

class PasswordViewController: UIViewController {

    @IBOutlet weak var tvPasswords: UITextView!
    
    var numberOfCharacters: Int = 10 // default se usuario nao enviar
    var numberOfPasswords: Int = 1
    var useLetters: Bool!
    var useNumbers: Bool!
    var useCapitalLetters: Bool!
    var useSpecialCharacters: Bool!
    
    var passwordGenerator: PasswordGenerator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordGenerator = PasswordGenerator(numberOfCharacters: numberOfCharacters,
                                              useLetters: useLetters,
                                              useNumbers: useNumbers,
                                              useCapitalLetters: useCapitalLetters,
                                              useSpecialLetters: useSpecialCharacters)
        
        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        
        tvPasswords.text = ""
        for password in passwords {
            tvPasswords.text.append(password + "\n\n")
        }

    }

    @IBAction func generatePasswordsAgain(_ sender: UIButton) {
        // posiciona a scroll no topo da view
        tvPasswords.scrollRangeToVisible(NSRange(location: 0, length: 0))
        tvPasswords.text = "" // limpa a view

        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        for password in passwords {
            tvPasswords.text.append(password + "\n\n")
        }

    }
}
