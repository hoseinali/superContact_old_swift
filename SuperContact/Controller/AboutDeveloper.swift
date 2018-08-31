//
//  About Developer.swift
//  ContacsDelete
//
//  Created by hosein on 8/26/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class AboutDeveloper: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Func
    
    func updateUI() {
        showAnimate()
        let tapGeuster = UITapGestureRecognizer.init(target: self, action: #selector (dissmiss(_:)) )
        self.view.addGestureRecognizer(tapGeuster)
    }
    
    @objc func dissmiss(_ sender: UITapGestureRecognizer) {
        print("1")
        removeAnimate()
    }

 

}
