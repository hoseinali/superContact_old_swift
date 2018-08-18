
import UIKit
import ContactsUI

class SameNameTableViewController: UITableViewController {
    
    // MARK: - Property
    
    var contacts = [CNContact]()
    var sameNameContact = [[CNContact]]() {
        didSet {
            if sameNameContact.count == 0 {
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
             self.wraningAlertDelete(titel: nil, message: "Do you want to merge \(sameNameContact.count) contacts", okButton: "Yes", cancelButton: "No", functionAction: mergeAction, functioncancel: mergeCancel)
    }
    
    // MARK: - Func
    
    func mergeAction() {
        
        SameContactName.shared.meregeSameContact(SameContact: sameNameContact)
        self.WarningfinishAlert(titel: nil, message: "You merged \(self.sameNameContact.count) contacts", okButton: "Ok")
        self.sameNameContact = []
        tableView.reloadData()
       
    }
    
    func findSameName() {
        FetchContact.shared.fetchContactRequest { (sucess) in
            if sucess {
                self.contacts = FetchContact.shared.contacts!
                self.sameNameContact = SameContactName.shared.findSameContactName(contacts: self.contacts)
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
        if segue.identifier == GO_TO_DETAIL_SAME_NAME {
            guard let indexpath = tableView.indexPathForSelectedRow else { return }
            let destinationVc = segue.destination as! DetailSameNameTableViewController
            print(sameNameContact[indexpath.row])
            destinationVc.contacts = sameNameContact[indexpath.row]
        }
    }
    
    
}

    // MARK: - TableView

extension SameNameTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sameNameContact.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SAME_NAME_CELL, for: indexPath)
        let contacts = sameNameContact[indexPath.row]
        let name = FetchContact.shared.nameContact(contact: contacts[0])
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = "\(contacts.count) contacts"
        return cell
    }
    
}
