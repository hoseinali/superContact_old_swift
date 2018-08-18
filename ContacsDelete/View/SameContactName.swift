

import UIKit
import ContactsUI

class SameContactName {
   static let shared = SameContactName()
    
    func findSameContactName(contacts: [CNContact]) -> [[CNContact]] {
        var sameNameDic = [String:[CNContact]]()
        var sameContacts = [[CNContact]]()
        for contact in contacts {
            let name = FetchContact.shared.nameContact(contact: contact)
            if let _ = sameNameDic[name] {
                sameNameDic[name]!.append(contact)
            } else {
                sameNameDic[name] = [contact]
            }
        }
        for contacts in sameNameDic.values {
            if contacts.count > 1 {
                sameContacts.append(contacts)
            }
        }
    return sameContacts
    }
    
    func meregeSameContact(SameContact:[[CNContact]]) {
        for contacts in SameContact {
            var cnLabelsPhoneNumbers = [CNLabeledValue<CNPhoneNumber>]()
            let FirstContact = contacts[0]
            var contactsDelete = [CNContact]()
            for phoneNumber in FirstContact.phoneNumbers {
            cnLabelsPhoneNumbers.append(phoneNumber)
            }
          for  index in 1 ... contacts.count - 1 {
            let contact = contacts[index]
            contactsDelete.append(contact)
            for phoneNumber in contact.phoneNumbers {
                var labelNumber = phoneNumber.label!
                labelNumber = String(labelNumber.dropFirst(4))
                labelNumber = String(labelNumber.dropLast(4)).lowercased()
                print(labelNumber)
                cnLabelsPhoneNumbers.append(contact.phoneNumbers[0].settingLabel("\(String(describing: labelNumber))\(index)"))
            }
            }
            FetchContact.shared.deleteContactSave(contacts: contactsDelete) { (sucess) in
                if sucess {
                    self.addPhoneNumber(CNLabels: cnLabelsPhoneNumbers, contact: FirstContact)
                }
            }
        }
    }
    
    func addPhoneNumber(CNLabels: [CNLabeledValue<CNPhoneNumber>], contact: CNContact) {
        if #available(iOS 9.0, *) {
            let store = CNContactStore()
            let contact = contact.mutableCopy()  as! CNMutableContact
            contact.phoneNumbers = CNLabels
            let request = CNSaveRequest()
            request.update(contact)
            do {
                try store.execute(request)
            } catch let e {
                print(e)
            }
        }
    }
    
    
}
