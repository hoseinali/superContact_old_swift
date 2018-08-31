//
//  SecurityTableViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/29/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class SecurityTableViewController: UITableViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var swiftch: UISwitch!
    @IBOutlet weak var changPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Password.shared.isTouchID {
            swiftch.isOn = true
        } else {
            swiftch.isOn = false
        }
        updateUI()
        

    }
    
    // MARK: - Action
    @IBAction func SwiftActionChange(_ sender: UISwitch) {
        if sender.isOn == true {
            Password.shared.isTouchID = true
            NotificationCenter.default.post(name: TOUCH_ID_ENABLE, object: nil)
        } else {
            Password.shared.isTouchID = false
            NotificationCenter.default.post(name: TOUCH_ID_ENABLE, object: nil)

        }
    }
    
    // MARK: - Func
    func updateUI() {
        if Password.shared.isCeratedPassword {
            changPassword.text = "Change Password"
        } else {
            changPassword.text = "Set Password"
        }
    }


}
