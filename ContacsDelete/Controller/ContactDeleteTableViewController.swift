
import UIKit
import ContactsUI
import NVActivityIndicatorView


class ContactDeleteTableViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource, UISearchResultsUpdating {
 
    // MARK: - property
    var filterdContact = [CNContact]()
    var contacts:[CNContact]?
    let searchController = UISearchController(searchResultsController: nil)
    var titelSections:[String]?
    var contactDict:[String:[CNContact]]?
    var isAll:Bool = true
    var spinner : NVActivityIndicatorView!
    var indicator = UIActivityIndicatorView()
    var contactSelected = [CNContact]() {
        didSet {
            selecetdContacts.title = "(\(contactSelected.count))"
        }
    }
    let allLetter = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]
    var engIndexpath = [String]()

    // MARK: - outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TrashButton: UIBarButtonItem!
    @IBOutlet weak var selecetdContacts: UIBarButtonItem!
    @IBOutlet weak var allOrNone: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - action
    
    @IBAction func deleteButtonPressed(_ sender: UIBarButtonItem) {
        self.wraningAlertDelete(titel: nil, message: nil, okButton: "Delete(\(contactSelected.count))", cancelButton: "Cancel", functionAction: deleteSelectedContact, functioncancel: cancelButtonAlert)
   
    }
    
    @IBAction func allButtonPressed(_ sender: UIBarButtonItem) {
        if isAll {
            allindexpathTableView()
            CheckTrashButton()
            isAll = false
            allOrNone.image = UIImage.init(named: "none")
        } else {
            contactSelected = []
            CheckTrashButton()
            tableView.reloadData()
            isAll = true
            allOrNone.image = UIImage.init(named: "multiSelected")
        }
    }


    
    // MARK: - func
    func updateUI() {
        spinner = self.created(typeSpinner: .ballBeat)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = #colorLiteral(red: 1, green: 0.4464405179, blue: 0, alpha: 1)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.setImage(UIImage(named: "SearchIcon"), for: .search, state: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search Contact", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        navigationItem.searchController = searchController
        definesPresentationContext = true
        tableView.tableFooterView = UIView()
        TrashButton.isEnabled = false
        navigationItem.hidesSearchBarWhenScrolling = false
        FetchContact.shared.fetchContactRequest { (sucess) in
            if sucess {
                self.contacts = FetchContact.shared.contacts
                self.sortedTitel()
                self.tableView.reloadData()
            }
        }
        tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func CheckTrashButton() {
        if contactSelected.count == 0 {
            TrashButton.isEnabled = false
        } else {
            TrashButton.isEnabled = true
        }
    }
    
    func allindexpathTableView() {
       contactSelected = [CNContact]()
        guard let contacts = contacts else { return }
        if contacts.count != 0 {
            for contact in contacts {
                contactSelected.append(contact)
            }
            tableView.reloadData()
        }
    }
    
    func sortedTitel() {
       guard let contacts = contacts else { return }
        contactDict = [String:[CNContact]]()
        titelSections = [String]()
        for contact in contacts {
            var nameContact = FetchContact.shared.nameContact(contact: contact)
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
    
    func deleteSelectedContact() {
        //self.indicator.startAnimating()
        spinner.startAnimating()
        self.TrashButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
            FetchContact.shared.deleteContactSave(contacts: self.contactSelected) { (sucess) in
                if sucess {
                    FetchContact.shared.fetchContactRequest(completion: { (sucess) in
                        if sucess {
                            self.contacts = FetchContact.shared.contacts
                            self.sortedTitel()
                            self.tableView.reloadData()
                            self.tableView.tableFooterView = UIView()
                            self.spinner.stopAnimating()
                            self.WarningfinishAlert(titel: "Succeed", message: "\(self.contactSelected.count) contacts deleted", okButton: "Ok")
                            self.contactSelected = []
                            self.indicator.stopAnimating()
                        }
                    })
                }
            }
        }
    }
    
    func cancelButtonAlert() {
        TrashButton.isEnabled = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterdContentForSerachText(searchController.searchBar.text!)
    }
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterdContentForSerachText(_ serachText:String) {
        guard let contacts = contacts else { return }
        filterdContact = contacts.filter({ (contact:CNContact) -> Bool in
           return FetchContact.shared.nameContact(contact: contact).lowercased().contains(serachText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        guard let titelSections = titelSections else { return 0 }
        if isFiltering() {
            return 1
        }

        return titelSections.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contactDict = contactDict else { return 0 }
        guard let titelSections = titelSections else { return 0 }
        if isFiltering() {
            return filterdContact.count
        }
        let titelSection = titelSections[section]
        guard let contacts = contactDict[titelSection] else {return 0}
    

        return contacts.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DELETE_CONATACT_CELL , for: indexPath)
        cell.tintColor = #colorLiteral(red: 1, green: 0.4945720997, blue: 0.07470703125, alpha: 1)
        guard let titelSections = titelSections else { return cell }
        guard let contactDict = contactDict else { return cell }
        var contact = CNContact()
        if isFiltering() {
           contact =  filterdContact[indexPath.row]
            
        } else {
        let titelSection = titelSections[indexPath.section]
        let contactsSection = contactDict[titelSection]
         contact = contactsSection![indexPath.row]
        }
        if contactSelected.contains(contact){
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = FetchContact.shared.nameContact(contact: contact)
        if contact.phoneNumbers.count > 0 {
        let numberPhone = contact.phoneNumbers[0].value.stringValue
        if numberPhone.isEmpty {
            cell.detailTextLabel?.text = "NO Number"
        } else {
        cell.detailTextLabel?.text = numberPhone
        }
        } else {
            cell.detailTextLabel?.text = "NO Number"
        }
      cell.detailTextLabel?.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let titelSections = titelSections else { return nil }
        if isFiltering() {
           return nil
            
        }
        return titelSections[section]
    }
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = #colorLiteral(red: 1, green: 0.4464405179, blue: 0, alpha: 1)
        header.textLabel?.font = UIFont(name: "SinkinSans-400Regular", size: 20)!
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        guard let contactDict = contactDict else { return  }
        guard let titelSections = titelSections else { return }
        var contact = CNContact()
        if isFiltering() {
            contact = filterdContact[indexPath.row]
        } else {
             contact = contactDict[titelSections[indexPath.section]]![indexPath.row]
        }
      
        if contactSelected.contains(contact) {
            cell.accessoryType = .none
            contactSelected = contactSelected.filter({ $0 != contact })
            } else {
            contactSelected.append(contact)
            cell.accessoryType = .checkmark
        }
        CheckTrashButton()
    }

    
     func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       engIndexpath = titeSectionIndexpath()
        return engIndexpath
    }
    
     func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = titelSections?.index(of: title) else { return 0 }
        return index
    }

    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }
    
}
