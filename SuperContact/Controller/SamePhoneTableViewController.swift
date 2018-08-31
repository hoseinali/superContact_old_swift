//
//  SamePhoneTableViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/9/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit
import ContactsUI

class SamePhoneTableViewController: UITableViewController {
    
    // MARK: - Property
    var contacts = [CNContact]()
    var samePhone = [[CNContact]]()
    
    // MARK: - Outlet
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        }


    // MARK: - action
    @IBAction func findButtonPressed(_ sender: UIBarButtonItem) {
        findSamePhone()
    }
    

    
    // MARK: - Func
    func updateUI() {
    tableView.tableFooterView = UIView()
    NotificationCenter.default.addObserver(self, selector: #selector(fetechSamePhoneData(_:)), name: FETECH_SAME_PHONE_NOTIFICATION, object: nil)
    }
    
    func findSamePhone() {
        FetchContact.shared.fetchContactRequest { (sucess) in
            if sucess {
                self.contacts = FetchContact.shared.contacts!
                self.samePhone = SamePhone.shared.findSameContactPhone(contacts: self.contacts)
                print(self.samePhone.count)
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - object
    @objc func fetechSamePhoneData(_ notifi: Notification) {
        findSamePhone()
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GO_TO_DETIAL_SAME_PHONE {
            let destination = segue.destination as! DetailSamePhoneTableViewController
            destination.contacts = samePhone[(tableView.indexPathForSelectedRow?.row)!]
        }
        
    }
    
}

    // MARK: - Table view
    extension SamePhoneTableViewController {
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return samePhone.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: SAME_PHONE_CELL, for: indexPath)
            let contacts = samePhone[indexPath.row]
            cell.textLabel?.text = contacts[0].phoneNumbers[0].value.stringValue
            cell.detailTextLabel?.text = "\(contacts.count) contacts"
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
        
}

