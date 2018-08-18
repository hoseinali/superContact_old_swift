//
//  UiViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/5/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

extension UIViewController {

    func wraningAlertDelete(titel: String?, message: String?, okButton: String, cancelButton: String , functionAction: @escaping () ->  Void ,functioncancel: @escaping () ->  Void ) {
        let alert = UIAlertController.init(title: titel, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction.init(title: okButton, style: .default) { (action) in
            functionAction()
        }
        let cancel = UIAlertAction.init(title: cancelButton, style: .cancel) { (action) in
            functioncancel()
        }
        alert.addAction(action)
        alert.addAction(cancel)
        alert.view.tintColor = UIColor.red
        present(alert, animated: true, completion: nil)
        }
    
    func WarningfinishAlert (titel: String?, message: String?, okButton: String) {
        let alert = UIAlertController.init(title: titel, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: okButton, style: .cancel, handler: nil)
        alert.addAction(action)
        alert.view.tintColor = UIColor.red
        present(alert, animated: true, completion: nil)
    }
    
    
}
