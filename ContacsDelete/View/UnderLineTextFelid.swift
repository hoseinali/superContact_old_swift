//
//  UnderLineTextFelid.swift
//  ContacsDelete
//
//  Created by hosein on 8/27/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit
@IBDesignable


class UnderLineTextFelid: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    
   func setupView() {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.width, height: 1)
    bottomLine.borderColor = UIColor.darkGray.cgColor
    self.borderStyle = UITextBorderStyle.none
    self.layer.addSublayer(bottomLine)
    self.layer.masksToBounds = true
    }
}
