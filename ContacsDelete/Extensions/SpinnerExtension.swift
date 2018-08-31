//
//  SpinnerExtension.swift
//  ContacsDelete
//
//  Created by hosein on 8/4/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

extension UIViewController {
    
    func created(typeSpinner:NVActivityIndicatorType) -> NVActivityIndicatorView {
        let frames = CGRect.init(x: self.view.center.x, y: self.view.center.y, width: 80, height: 80)
        let spinner = NVActivityIndicatorView.init(frame: frames, type: typeSpinner, color: #colorLiteral(red: 0.1504255873, green: 0.1628690705, blue: 0.1809463608, alpha: 1), padding: 0)
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint.init(item: spinner, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: spinner, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
        self.view.backgroundColor = UIColor.darkGray
        return spinner
    }
    
    func removeSpinner(spinner:NVActivityIndicatorView) {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }

    
    
}
