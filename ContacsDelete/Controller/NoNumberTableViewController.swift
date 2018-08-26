

import UIKit
import ContactsUI

class NoNumberTableViewController: UITableViewController {
    
    // MARK: - Property
    
    var contacts = [CNContact]()
    var noNumberContact = [CNContact]()
    var contactSelected = [CNContact]() {
        didSet {
            if contactSelected.count > 0 {
                deleteButton.isEnabled = true
            } else {
                deleteButton.isEnabled = false
            }
        }
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }

    // MARK: - Func
    
    func updateUI() {
        deleteButton.isEnabled = false
        tableView.tableFooterView = UIView()
    }
    
    func deleteContact() {
        FetchContact.shared.deleteContactSave(contacts: contactSelected) { (sucess) in
            if sucess {
                for contact in self.contactSelected {
                    self.noNumberContact = self.noNumberContact.filter({ $0 != contact})
                }
           
                self.WarningfinishAlert(titel: nil, message: "\(self.contactSelected.count) contacts deleted ", okButton: "Ok")
                self.contactSelected = []
                self.tableView.reloadData()
            }
        }
    }
    
    func cancelAction() {
      //
    }
    
    // MARK: - Action
    
    @IBAction func findButtonPressed(_ sender: Any) {
        FetchContact.shared.fetchContactRequest { (sucess) in
            if sucess {
                self.contacts = FetchContact.shared.contacts!
                self.noNumberContact = NoContactNumber.shared.findNoNumber(contacts: self.contacts)
                self.tableView.reloadData()
                
            }
        }
        
    }
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        self.wraningAlertDelete(titel: nil, message: "Do you want delete \(contactSelected.count) contacts ? ", okButton: "Yes", cancelButton: "NO", functionAction: deleteContact, functioncancel: cancelAction)
    }
    
}

// MARK: - Table view data source

extension NoNumberTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noNumberContact.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NO_NUMBER_CELL, for: indexPath)
        let contact = noNumberContact[indexPath.row]
        if contactSelected.contains(contact) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        let name = FetchContact.shared.nameContact(contact: contact)
        if name.isEmpty {
             cell.textLabel?.text = "No name"
        } else {
            cell.textLabel?.text = name
        }
        cell.detailTextLabel?.text = "No phone"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let contact = noNumberContact[indexPath.row]
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
          contactSelected = contactSelected.filter({$0 != contact})
        } else if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            contactSelected.append(contact)
        }
    }
    
}
