//
//  SecretContactViewController.swift
//  ContacsDelete
//
//  Created by hosein on 7/30/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit


class PrivateContactViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
  
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Property
    var contacts = [PVContact]()
    var contactSelected:PVContact?
    var titelSections:[String]?
    var contactDict:[String:[PVContact]]?
    let allLetter = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]


    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
 
    }


    
   
    // MARK: - Action
    @IBAction func addContactButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToCerated", sender: nil)
        
    }
    
    @objc func updateNotifaction(_ notifi: NotificationCenter) {
            contacts = contacts.filter({ $0 != contactSelected!})
            sortedTitel()
            tableView.reloadData()
        PVContact.save(pVContact: contacts)
     
    }
    
    @objc func deleteNotifaction(_ notifi: NotificationCenter) {
                contacts = contacts.filter({ $0 != contactSelected!})
                sortedTitel()
                tableView.reloadData()
                PVContact.save(pVContact: contacts)
        
    }
   
    
    // MARK: - func
    func updateUI() {
        if PVContact.load() != nil {
            contacts = PVContact.load()!
        }
        NotificationCenter.default.addObserver(self, selector: #selector(deleteNotifaction(_:)), name: DELETE_PV, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateNotifaction(_:)), name: UPDATE_PV, object: nil)

        tableView.delegate = self
        tableView.dataSource = self
        sortedTitel()
        tableView.reloadData()

    }
    

    func sortedTitel() {
        contactDict = [String:[PVContact]]()
        titelSections = [String]()
        for contact in contacts {
            var nameContact = namePVContact(contact: contact)
            nameContact = nameContact.uppercased()
            let firstLetterIndex = nameContact.index(nameContact.startIndex, offsetBy: 1)
            let firstLetterContact = nameContact.substring(to: firstLetterIndex)
            if var contacts = contactDict![firstLetterContact] {
                contacts.append(contact)
                contactDict![firstLetterContact] = contacts
            } else {
                contactDict![firstLetterContact] = [contact]
            }
            titelSections = [String](contactDict!.keys)
            titelSections = titelSections!.sorted(by: {$0 < $1})
        }
    }
    
    func titeSectionIndexpath() -> [String] {
        guard let titelSections = titelSections else { return []}
        var titeles = [String]()
        for titel in titelSections {
            if allLetter.contains(titel) {
                titeles.append(titel)
            }
        }
        return titeles
    }
    
    func namePVContact(contact:PVContact) -> String {
        return contact.firstName + " " + contact.lastName + " " + contact.companyName
    }
    
}
// MARK: - TableView

extension PrivateContactViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let titelSections = titelSections else { return 0 }

        return titelSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contactDict = contactDict else { return 0 }
        guard let titelSections = titelSections else { return 0 }
        let titelSection = titelSections[section]
        guard let contacts = contactDict[titelSection] else {return 0}
        
        return contacts.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SECRET_CONTACT_CELL, for: indexPath) as! PVTableViewCell
        cell.tintColor = #colorLiteral(red: 1, green: 0.4945720997, blue: 0.07470703125, alpha: 1)
        guard let titelSections = titelSections else { return cell }
        let titelSection = titelSections[indexPath.section]
        guard let contactDict = contactDict else { return cell }
        let contactsSection = contactDict[titelSection]
        let contact = contactsSection![indexPath.row]
        cell.configureCell(image: contact.image, name: namePVContact(contact: contact))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contactDict = contactDict else { return }
        guard let titelSections = titelSections else { return }
        let titelSection = titelSections[indexPath.section]
        guard let contacts = contactDict[titelSection] else {return}
        contactSelected = contacts[indexPath.row]
        performSegue(withIdentifier: "goToDetial", sender: nil)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let titelSections = titelSections else { return nil }
        return titelSections[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = #colorLiteral(red: 1, green: 0.4464405179, blue: 0, alpha: 1)
        header.textLabel?.font = UIFont(name: "SinkinSans-400Regular", size: 20)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetial" {
            let destaion = segue.destination as! DetialContactViewController
            destaion.contact = contactSelected
        }
    }
    @IBAction func unwindTOPV(_ sender: UIStoryboardSegue) {
        if sender.identifier == "unwindTopv" {
            updateUI()
        }
    }

}
