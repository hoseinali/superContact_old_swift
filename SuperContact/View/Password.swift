//
//  Password.swift
//  ContacsDelete
//
//  Created by hosein on 8/15/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation

class Password {
    static let shared = Password()
    let defaults = UserDefaults.standard
    var password: String {
        get {
            return defaults.string(forKey: PASSWORD_KEY)! 
        }
        set {
            defaults.set(newValue, forKey: PASSWORD_KEY)
        }
    }
    var isCeratedPassword: Bool {
        get {
            return defaults.bool(forKey: IS_CERATED_PASSWORD)
        }
        set {
            defaults.set(newValue, forKey: IS_CERATED_PASSWORD)
        }
    }
    var isTouchID: Bool {
        get {
            return defaults.bool(forKey: TOUCH_ID)
        }
        set {
            defaults.set(newValue, forKey: TOUCH_ID)
        }
    }
}
