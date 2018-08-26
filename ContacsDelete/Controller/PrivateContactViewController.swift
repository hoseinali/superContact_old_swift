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
    
    var contacts = [PrivateContact]()
    var titelSections:[String]?
    var contactDict:[String:[PrivateContact]]?
    let allLetter = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]


    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = [(PrivateContact.init(name: "hosein", tel: "0934354345", email: "hoseim@gmail.com", image: nil)), (PrivateContact.init(name: "mohamad", tel: "09546564564", email: "mohamad@gmail.com", image: nil)), (PrivateContact.init(name: "hassan", tel: "09330550345", email: "mohamad@gmail.com", image: nil)) ]
        tableView.reloadData()
        updateUI()
 
    }


    
   
    // MARK: - Action
    @IBAction func addContactButtonPressed(_ sender: UIBarButtonItem) {
        let addContact = AddContactViewController()
        self.addChildViewController(addContact)
        addContact.view.frame = self.view.frame
        self.view.addSubview(addContact.view)
        addContact.didMove(toParentViewController: self)
    }
    
    // MARK: - func
    func updateUI() {
        tableView.delegate = self
        tableView.dataSource = self
        sortedTitel()
    }
    
    func sortedTitel() {
        contactDict = [String:[PrivateContact]]()
        titelSections = [String]()
        for contact in contacts {
            var nameContact = contact.name
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
    
}
    
extension PrivateContactViewController {
    // tableView
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
        cell.configureCell(image: contact.image, name: contact.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let contact = contacts[indexPath.row]
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    
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
        header.textLabel?.font = UIFont(name: FONT_TITEL, size: 20)!
    }

}
