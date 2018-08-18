//
//  LockViewController.swift
//  ContacsDelete
//
//  Created by hosein on 7/29/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    // outlet
    @IBOutlet weak var confirmStackView: UIStackView!
    @IBOutlet weak var createdPasswordLabel: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UITextField!
    @IBOutlet weak var enterPassword: UIStackView!
    
    var passwordText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // ACTION
    
    // check pass
    @IBAction func checkPassChangeTextfield(_ sender: UITextField) {
        if sender.text! == Password.shared.password {
            print("sucess password")
            performSegue(withIdentifier: GO_TO_SECRET_CONTACT, sender: nil)
        } else {
            print("failed password")
        }
    }
    // password Confirm
    @IBAction func okButtonPressed(_ sender: UIButton) {
        if (createdPasswordLabel.text?.isEmpty)! && (confirmPasswordLabel.text?.isEmpty)! {
            self.WarningfinishAlert(titel: "Password didn't enter", message: "Please enter your password", okButton: "OK")
            
        } else if createdPasswordLabel.text == confirmPasswordLabel.text {
            Password.shared.password = confirmPasswordLabel.text!
            Password.shared.isCeratedPassword = true
            print("Created Password")
            
            
            performSegue(withIdentifier: GO_TO_SECRET_CONTACT, sender: nil)
        } else {
          self.WarningfinishAlert(titel: "Password doesn't match confirm", message: "Please provide identical inputs", okButton: "OK")
        }
    }
    
    // FUNC
    
    func updateUI() {
        self.view.hiddenKeyboard()
        if Password.shared.isCeratedPassword {
            confirmStackView.isHidden = true
            enterPassword.isHidden = false
            print("iscerated")
        } else {
            confirmStackView.isHidden = false
            enterPassword.isHidden = true
            print("enterPass")
        }
    }
    
    
    
}
