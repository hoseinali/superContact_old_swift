//
//  RoudedImage.swift
//  ContacsDelete
//
//  Created by hosein on 8/26/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit
@IBDesignable

class RoudedImage: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    // Fuctions
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }

}
