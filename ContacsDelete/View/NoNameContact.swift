//
//  NoNameContact.swift
//  ContacsDelete
//
//  Created by hosein on 8/13/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation
import ContactsUI

class NoNameContact {
    
   static let shared = NoNameContact()
    
    func findNoNmae(_ contacts: [CNContact]) -> [CNContact] {
        let noName = contacts.filter {
            let name = $0.givenName + $0.familyName + $0.middleName
            if name.isEmpty {
                return true
            } else {
                return false
            }
        }
        return noName
   }
    
    
}
