//
//  SameContact.swift
//  ContacsDelete
//
//  Created by hosein on 8/14/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation
import ContactsUI

class SameContact {
    static let shared = SameContact()
    
    func findSameContact(_ contacts:[CNContact]) -> [[CNContact]] {
        var sameContactDic = [String:[CNContact]]()
        var sameContact = [[CNContact]]()
        for contact in contacts {
            let name = FetchContact.shared.nameContact(contact: contact)
            var phone = ""
            if contact.phoneNumbers.count == 0 {
                phone = "No number"
                } else {
                phone = SamePhone.shared.CretaedNumbersContact(contact)
            }
            let nameAndPhone = name + phone
            if let _ = sameContactDic[nameAndPhone] {
                sameContactDic[nameAndPhone]?.append(contact)

            } else {
                sameContactDic[nameAndPhone] = [contact]
            }
        }
        
        for contacts in sameContactDic.values {
            if contacts.count > 1 {
                sameContact.append(contacts)
            }
        }
        return sameContact
    }
    
    func meregeContact(_ contacts:[[CNContact]]) {
        var contacts = contacts
        for index in 0 ... contacts.count - 1 {
            contacts[index].remove(at: 0)
            
        }
        for contact in contacts {
            FetchContact.shared.deleteContactSave(contacts: contact) { (sucess) in
                if sucess {
                    print("sucess")
                }
            }
        }
    }
    
    
}
