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
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

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
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                                    attributes: [NSAttributedStringKey.foregroundColor: colorPlaceholder])
        

    }
  
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
    

