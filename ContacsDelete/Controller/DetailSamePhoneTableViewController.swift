

import UIKit
import ContactsUI

class DetailSamePhoneTableViewController: UITableViewController {
    
    // MARK: - Property
    var contacts = [CNContact]()
    var contactsSelected = [CNContact]() {
        didSet {
            if contactsSelected.count > 0 {
                deleteBarButtonItem.isEnabled = true
            } else {
                deleteBarButtonItem.isEnabled = false
            }
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var deleteBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    //MARK: - Action
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        self.wraningAlertDelete(titel: nil, message: "Do you want Delete \(contactsSelected.count) contacts ?", okButton: "Yes", cancelButton: "No", functionAction: deleteContact, functioncancel: cancelDelete)
    }
    
    
    
    // MARK: - Func
    func deleteContact() {
        FetchContact.shared.deleteContactSave(contacts: contactsSelected) { (sucess) in
            if sucess {
                for contact in self.contactsSelected {
                    self.contacts = self.contacts.filter({ $0 != contact })
                }
                self.tableView.reloadData()
                self.WarningfinishAlert(titel: nil, message: "\(self.contactsSelected.count) contacts deleted ", okButton: "Ok")
                NotificationCenter.default.post(name: FETECH_SAME_PHONE_NOTIFICATION, object: nil)
            }
        }
    }
    
    func cancelDelete() {
        //
    }
    func updateUI() {
        tableView.tableFooterView = UIView()
        
    }



}


// MARK: - Table view

extension DetailSamePhoneTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DETAIL_SAME_PHONE_CELL, for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = FetchContact.shared.nameContact(contact: contact)
        cell.detailTextLabel?.text = contact.phoneNumbers[0].value.stringValue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell.accessoryType == .none {
            contactsSelected.append(contact)
            cell.accessoryType = .checkmark
        } else if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            contactsSelected = contactsSelected.filter({$0 != contact})

        }
    }
    
}
