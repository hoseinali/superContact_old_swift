//
//  add ContactViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/25/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var phoneName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var companyName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    // MARK: - Action

    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        
    }
    



}
