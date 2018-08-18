//
//  SecretContactViewController.swift
//  ContacsDelete
//
//  Created by hosein on 7/30/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class SecretContactViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var telLabel: UILabel!
    var contacts:[CreatedContact]?

    override func viewDidLoad() {
        super.viewDidLoad()
        //contacts = [CreatedContact.init(tel: 09330550356, name: " ", family: " ")]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }


    
   
    // action
    @IBAction func addContactButtonPressed(_ sender: UIBarButtonItem) {
        
        
    }
    
    
    
    
    // tableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let contact = contacts {
            return contact.count
        } else {
            return 0
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SECRET_CONTACT_CELL, for: indexPath)
        if let contact = contacts {
        //cell.textLabel?.text = String(contact[indexPath.row].tel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let number = String(contacts![indexPath.row].tel)
       // guard let numberURL = URL(string: "tel://" + number) else { return }
       // UIApplication.shared.open(numberURL)
    }

}
