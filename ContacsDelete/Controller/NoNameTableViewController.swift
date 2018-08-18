
import UIKit
import ContactsUI

class NoNameTableViewController: UITableViewController {

    
    // MARK: - Property
    
    var contacts = [CNContact]()
    var noNameContact = [CNContact]()
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
                    self.noNameContact = self.noNameContact.filter({ $0 != contact})
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
                self.noNameContact = NoNameContact.shared.findNoNmae(self.contacts)
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        self.wraningAlertDelete(titel: nil, message: "Do you want delete \(contactSelected.count) contacts ? ", okButton: "Yes", cancelButton: "NO", functionAction: deleteContact, functioncancel: cancelAction)
    }
    
}

// MARK: - Table view data source

extension NoNameTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noNameContact.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NO_NAME_CELL, for: indexPath)
        let contact = noNameContact[indexPath.row]
        if contactSelected.contains(contact) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = "No name"
        cell.detailTextLabel?.text = contact.phoneNumbers[0].value.stringValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let contact = noNameContact[indexPath.row]
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            contactSelected = contactSelected.filter({$0 != contact})
        } else if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            contactSelected.append(contact)
        }
    }
    
}
