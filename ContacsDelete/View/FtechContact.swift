//  FtechContact.swift
//  ContacsDelete
//  Created by hosein on 7/21/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.

import Foundation
import ContactsUI

class FetchContact {
    static let shared = FetchContact()
    let conatctStore = CNContactStore()
    var contacts:[CNContact]?
    
 
    func fetchContactRequest(completion: @escaping COMPLETION_SUCCESS) {
        contacts = [CNContact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactPhoneNumbersKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor] )
        do {
            try conatctStore.enumerateContacts(with: request, usingBlock: { (contact, stop) in
               self.contacts!.append(contact)
            })
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }

    }
    
   
    func deleteContactSave(contacts: [CNContact], completion: @escaping COMPLETION_SUCCESS) {
        let disPathGroup = DispatchGroup()
        for contact in contacts {
            disPathGroup.enter()
        let request = CNSaveRequest()
        let mutableContact = contact.mutableCopy() as! CNMutableContact
        request.delete(mutableContact)
        do {
            try conatctStore.execute(request)
            disPathGroup.leave()
        } catch {
            completion(false)
            disPathGroup.leave()
            }
        }
        disPathGroup.notify(queue: .main) {
            completion(true)
        }
    }
    
    func nameContact(contact:CNContact) -> String {
        return contact.givenName + " " + contact.familyName + " " + contact.middleName
    }
    
    func saveContact(_ contacts: [CNContact] ,completion: @escaping COMPLETION_SUCCESS) {
        for contact in contacts {
            let request = CNSaveRequest()
            let mutableContact = contact.mutableCopy() as! CNMutableContact
            request.update(mutableContact)
            do {
                try conatctStore.execute(request)
            } catch {
                completion(false)
            }
        }
        completion(true)
    }

}
