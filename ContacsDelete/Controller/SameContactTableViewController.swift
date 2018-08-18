//
//  SameContactTableViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/14/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit
import ContactsUI

class SameContactTableViewController: UITableViewController {

    // MARK: - Property
    
    var contacts = [CNContact]()
    var sameContact = [[CNContact]]() {
        didSet {
            if sameContact.count == 0 {
                mergeBarButtonItem.isEnabled = false
            } else {
                mergeBarButtonItem.isEnabled = true
            }
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var mergeBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
    }
    
    // MARK: - Action
    
    @IBAction func findBarButtonItem(_ sender: UIBarButtonItem) {
        findSameName()
    }
    
    @IBAction func mergeUIBarButton(_ sender: UIBarButtonItem) {
        self.wraningAlertDelete(titel: nil, message: "Do you want to merge \(sameContact.count) contacts", okButton: "Yes", cancelButton: "No", functionAction: mergeAction, functioncancel: mergeCancel)
    }
    
    // MARK: - Func
    
    func mergeAction() {
        
        SameContact.shared.meregeContact(sameContact)
        self.WarningfinishAlert(titel: nil, message: "You merged \(self.sameContact.count) contacts", okButton: "Ok")
        self.sameContact = []
        tableView.reloadData()
        
    }
    
    func findSameName() {
        FetchContact.shared.fetchContactRequest { (sucess) in
            if sucess {
                self.contacts = FetchContact.shared.contacts!
                self.sameContact = SameContact.shared.findSameContact(self.contacts)
                print(self.sameContact.count)
                self.tableView.reloadData()
            }
        }
    }
    
    func mergeCancel() {
        //
    }
    
    func UpdateUI() {
        tableView.tableFooterView = UIView()
        mergeBarButtonItem.isEnabled = false
    }
    
    // MARK: - PrepareSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == GO_TO_DETIAL_SAME_CONTACT {
            guard let indexpath = tableView.indexPathForSelectedRow else { return }
            let destinationVc = segue.destination as! DetialSameContactTableViewController
            destinationVc.contacts = sameContact[indexpath.row]
        }
    }
    
    
}

// MARK: - TableView

extension SameContactTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sameContact.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SAME_CONTACT_CELL, for: indexPath)
        let contacts = sameContact[indexPath.row]
        let name = FetchContact.shared.nameContact(contact: contacts[0])
        if name == "  " {
            cell.textLabel?.text = "No Name"
        } else {
            cell.textLabel?.text = name
        }
        cell.detailTextLabel?.text = "\(contacts.count) contacts"
        return cell
    }
    
}
