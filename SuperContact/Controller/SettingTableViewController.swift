//
//  SettingTableViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/26/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPathAbout = IndexPath.init(row: 1, section: 0)
        if indexPath == indexPathAbout {
            self.addPopUpAboutUs()
        }

    }


    
}
