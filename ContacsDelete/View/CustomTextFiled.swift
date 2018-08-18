//
//  CustomTextFiled.swift
//  ContacsDelete
//
//  Created by hosein on 8/16/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

@IBDesignable

class CustomTextFiled:UITextField {
    
    // MARK: - IBInspectable propert
    
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var colorPlaceholder:UIColor = UIColor.gray {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                            attributes: [NSAttributedStringKey.foregroundColor: colorPlaceholder])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    // MARK: - Func
    
    func setupView() {
       self.layer.cornerRadius = cornerRadius
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                                    attributes: [NSAttributedStringKey.foregroundColor: colorPlaceholder])
    }
  
    
}
    

