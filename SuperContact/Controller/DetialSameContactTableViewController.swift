//
//  DetialSameContactTableViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/14/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit
import ContactsUI

class DetialSameContactTableViewController: UITableViewController {

    // MARK: - Property
    
    var contacts = [CNContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
        
    }
    
    //
    func UpdateUI() {
        tableView.tableFooterView = UIView()
        self.tableView.allowsSelection = false
        navigationItem.title = FetchContact.shared.nameContact(contact: contacts[0])
    }
    
}



// MARK: - TableView

extension DetialSameContactTableViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DETAIL_SAME_CONTACT_CELL, for: indexPath)
        let contact = contacts[indexPath.row]
        if contact.phoneNumbers.count == 0 {
            cell.detailTextLabel?.text = "No number"
        } else {
            cell.detailTextLabel?.text = contact.phoneNumbers[0].value.stringValue
        }
        if FetchContact.shared.nameContact(contact: contact) == "  " {
            cell.textLabel?.text = "No Name"
        } else {
            cell.textLabel?.text = FetchContact.shared.nameContact(contact: contact)
        }
        
        return cell
    }
    
}


