//
//  UIview.swift
//  ContacsDelete
//
//  Created by hosein on 8/16/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

extension UIView {
    
    func hiddenKeyboard() {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
    }
    @objc func handleTap() {
        self.endEditing(true)
    }
    
    
    
}
