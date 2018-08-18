//
//  File.swift
//  ContacsDelete
//
//  Created by hosein on 7/30/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation

struct CreatedContact {
    var name:String = " "
    var family:String = " "
    var tel:Int
    init(tel:Int, name:String, family:String) {
        self.tel = tel
        self.family = family
        self.name = name
    }
}
