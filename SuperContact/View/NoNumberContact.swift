

import ContactsUI

class NoContactNumber {
  
    static let shared = NoContactNumber()
    
    func findNoNumber(contacts: [CNContact]) -> [CNContact] {
        let noPhone = contacts.filter {
            if  $0.phoneNumbers.count > 0 {
                return false
                } else {
                return true
            }
        }
        return noPhone
    }
    

}
