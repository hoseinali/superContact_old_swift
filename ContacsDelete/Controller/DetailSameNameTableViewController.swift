
import UIKit
import ContactsUI

class DetailSameNameTableViewController: UITableViewController {
    
    // MARK: - Property
    
    var contacts = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
        

    }

    //
    func UpdateUI() {
        print(contacts.count)
        tableView.tableFooterView = UIView()
        self.tableView.allowsSelection = false
        navigationItem.title = FetchContact.shared.nameContact(contact: contacts[0])
    }
    
}



    // MARK: - TableView

extension DetailSameNameTableViewController {

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DETAIL_SAME_NAME_CELL, for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = FetchContact.shared.nameContact(contact: contact)
        if contact.phoneNumbers.count == 0 {
            cell.detailTextLabel?.text = "No number"
        } else {
            cell.detailTextLabel?.text = contact.phoneNumbers[0].value.stringValue
        }
        
        return cell
    }

}

