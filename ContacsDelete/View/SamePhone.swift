
import Foundation
import ContactsUI

class SamePhone {
    
    static let shared = SamePhone()
    
    func findSameContactPhone(contacts: [CNContact]) -> [[CNContact]] {
        var sameContactsDict = [String:[CNContact]]()
        var sameContacts = [[CNContact]]()
        for contact in contacts {
            if contact.phoneNumbers.count > 0 {
            let numberPhone = CretaedNumbersContact(contact)
            if let _ = sameContactsDict[numberPhone] {
                sameContactsDict[numberPhone]!.append(contact)
            } else {
                sameContactsDict[numberPhone] = [contact]
                }
            }
            }
        for contacts in sameContactsDict.values {
            if contacts.count > 1 {
                sameContacts.append(contacts)
            }
        }
        return sameContacts
    }
    
    func CretaedNumbersContact(_ contact: CNContact) -> String {
            var numberPhone = contact.phoneNumbers[0].value.stringValue
            if numberPhone.contains(" ") {
                numberPhone = numberPhone.components(separatedBy: .whitespaces).joined()
            }
            if numberPhone.count > 10 {
                numberPhone = String(numberPhone.suffix(10))
            }
            return numberPhone
    }
}
