//
//  PvContact.swift
//  ContacsDelete
//
//  Created by hosein on 8/27/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//


import UIKit

class PVContact:NSObject,NSCoding {
    
    var firstName:String
    var lastName:String
    var phone:String
    var image:UIImage?
    var companyName:String
    var email:String
    
    init(firstName:String, lastName:String, phone:String, image:UIImage?, companyName:String, email:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.image = image
        self.companyName = companyName
        self.email = email
        
    }
    
    static let archivedURL:URL = {
        
        let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return DocumentDirectory.appendingPathComponent("contacts")
        
        
        
    }()
    
    struct PropertyKeys{
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let phone = "phone"
        static let image = "image"
        static let companyName = "companyName"
        static let email = "email"
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: PropertyKeys.firstName)
        aCoder.encode(lastName, forKey: PropertyKeys.lastName)
        aCoder.encode(phone, forKey: PropertyKeys.phone)
        aCoder.encode(image, forKey: PropertyKeys.image)
        aCoder.encode(companyName, forKey: PropertyKeys.companyName)
        aCoder.encode(email, forKey: PropertyKeys.email)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard  let firstName = aDecoder.decodeObject(forKey: PropertyKeys.firstName) as? String else {return nil}
        guard  let lastName = aDecoder.decodeObject(forKey: PropertyKeys.lastName) as? String else {return nil}
        guard  let phone = aDecoder.decodeObject(forKey: PropertyKeys.phone) as? String else {return nil}
        guard  let companyName = aDecoder.decodeObject(forKey: PropertyKeys.companyName) as? String else {return nil}
        guard  let email = aDecoder.decodeObject(forKey: PropertyKeys.email) as? String else {return nil}
        
        let image = aDecoder.decodeObject(forKey: PropertyKeys.image) as? UIImage
        
        
        self.init(firstName: firstName, lastName: lastName, phone: phone, image: image, companyName: companyName, email: email)
        
    }
    static func save(pVContact: [PVContact]){
        NSKeyedArchiver.archiveRootObject(pVContact, toFile: archivedURL.path)
        
    }
    static func load()-> [PVContact]?{
        guard let pvContacts = NSKeyedUnarchiver.unarchiveObject(withFile: archivedURL.path) as? [PVContact] else {return nil}
        return pvContacts
    }
    
 
    
    
}
