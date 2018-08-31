//
//  SetPasswordViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/30/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class SetPasswordViewController: UIViewController {
    
    // MARK: - Property
    var currentPassword:String?
    
    
    // MARK: - Outlet
    @IBOutlet weak var passwordTextFiled: CustomTextFiled!
    @IBOutlet weak var confirmPasswordTextFiled: CustomTextFiled!
    @IBOutlet weak var currentPasswordTextFiled: CustomTextFiled!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    // MARK: - Action
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if Password.shared.isCeratedPassword {
            changePassword()
        } else {
             setPassword()
        }
    }
    
    // MARK: - Func
    func updateUI() {
        if Password.shared.isCeratedPassword {
            navigationItem.title = "Change Password"
            currentPasswordTextFiled.isHidden = false
            currentPassword = Password
            .shared.password
        } else {
            currentPasswordTextFiled.isHidden = true
            navigationItem.title = "Set Password"
        }
    }
    
    func setPassword() {
        if !passwordTextFiled.text!.isEmpty && confirmPasswordTextFiled.text! == passwordTextFiled.text! {
            warningSetPassword(titel: "Your password was created Successfully", message: "", okButton: "OK", functionAction: goTOSetting)
            Password.shared.password = passwordTextFiled.text!
            Password.shared.isCeratedPassword = true
        } else if !passwordTextFiled.text!.isEmpty && confirmPasswordTextFiled.text!.isEmpty {
            warningPasswordChangeFailed(titel: "Failed", message: "Passwords is empty", okButton: "OK")
        } else if confirmPasswordTextFiled.text! != passwordTextFiled.text! {
            warningPasswordChangeFailed(titel: "Failed", message: "Passwords do not match", okButton: "OK")
        }
        resetTextFiled()
    }
    
    func changePassword() {
        if currentPassword == currentPasswordTextFiled!.text {
        if !passwordTextFiled.text!.isEmpty && confirmPasswordTextFiled.text! == passwordTextFiled.text! {
            if passwordTextFiled.text! == currentPassword {
                warningPasswordChangeFailed(titel: "Failed", message: "your new password can't be the same as old password", okButton: "OK")
            } else {
                Password.shared.password = passwordTextFiled.text!
                        warningPasswordChangeFailed(titel: "Your password has changed Successfully", message: "", okButton: "OK")
            }
        } else if passwordTextFiled.text!.isEmpty && confirmPasswordTextFiled.text!.isEmpty {
            warningPasswordChangeFailed(titel: "Failed", message: "Passwords is empty", okButton: "OK")

        } else if confirmPasswordTextFiled.text! != passwordTextFiled.text! {
            warningPasswordChangeFailed(titel: "Failed", message: "Passwords do not match", okButton: "OK")
        }
        } else if currentPasswordTextFiled.text!.isEmpty {
            warningPasswordChangeFailed(titel: "Failed", message: "Password is empty", okButton: "OK")
        } else {
            warningPasswordChangeFailed(titel: "Failed", message: "Your old password was entered incorrectly. please enter it again.", okButton: "OK")
        }
        resetTextFiled()
    }
    
    func resetTextFiled() {
        passwordTextFiled.text = nil
        confirmPasswordTextFiled.text = nil
        currentPasswordTextFiled.text = nil
    }
    
    func goTOSetting() {
        let SecuritySetting = storyboard?.instantiateViewController(withIdentifier: "rootViewcontroller") as! UITabBarController
        present(SecuritySetting, animated: true, completion: nil)
    }
    
    
    
}
