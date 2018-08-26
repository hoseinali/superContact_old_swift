//
//  RoundedButton.swift
//  ContacsDelete
//
//  Created by hosein on 8/15/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 25{
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    // Fuctions
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }

    
}
