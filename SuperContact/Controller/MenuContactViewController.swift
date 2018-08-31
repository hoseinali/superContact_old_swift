
import UIKit
import ContactsUI

class MenuContactViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var bigestCountDuplicateLabel: UILabel!
    @IBOutlet weak var bigestNameDuplicate: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updateUI()
        
    }

    // MARK: - Action
    @IBAction func unwindToMenuContact(_ sender: UIStoryboardSegue) {
        
    }
    
    // MARK: - func
    func updateUI() {
        FetchContact.shared.fetchContactRequest { (sucess) in
            if sucess {
                let duplicatNumber = SamePhone.shared.findSameContactPhone(contacts: FetchContact.shared.contacts!)
                let duplicatContact = SameContact.shared.findSameContact(FetchContact.shared.contacts!)
                  let duplicatName = SameName.shared.findSameContactName(contacts: FetchContact.shared.contacts!)
                let noName = NoNameContact.shared.findNoNmae(FetchContact.shared.contacts!)
                let noPhone = NoContactNumber.shared.findNoNumber(contacts: FetchContact.shared.contacts!)
                if duplicatNumber.count > duplicatContact.count && duplicatNumber.count > duplicatName.count && duplicatNumber.count > noName.count && duplicatNumber.count > noPhone.count {
                    self.bigestCountDuplicateLabel.text = String(duplicatNumber.count)
                    self.bigestNameDuplicate.text = "Duplicate Numbers"
                } else if duplicatContact.count > duplicatName.count && duplicatContact.count > noName.count && duplicatContact.count > noPhone.count {
                    self.bigestNameDuplicate.text = "Duplicate Contacts"
                    self.bigestCountDuplicateLabel.text = String(duplicatContact.count)
                } else if duplicatName.count > noName.count && duplicatName.count > noPhone.count {
                    self.bigestCountDuplicateLabel.text = String(duplicatName.count)
                    self.bigestNameDuplicate.text = "Duplicate Names"
                } else if noName.count > noPhone.count {
                    self.bigestCountDuplicateLabel.text = String(noName.count)
                    self.bigestNameDuplicate.text = "NO Name"
                } else {
                    self.bigestCountDuplicateLabel.text = String(noPhone.count)
                    self.bigestNameDuplicate.text = "NO Phone"
                }
            }
        }
    }
    
    

}
