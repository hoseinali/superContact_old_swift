//
//  SecretViewController.swift
//  ContacsDelete
//
//  Created by hosein on 8/20/18.
//  Copyright © 2018 iPersianDeveloper. All rights reserved.
//

import UIKit

class SecretViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var contacts = [[HiddenContact]]()

    @IBOutlet weak var tabelView:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        contacts = [[HiddenContact.init(name: "hosein", tel: "464647", email: nil, isExpanded: false)],[HiddenContact.init(name:"hgjgkjg" , tel: "657575",email: nil, isExpanded: false)] ,[HiddenContact.init(name: "xfgdhd", tel: "5676", email: nil , isExpanded: false)]]

    }


    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !contacts[section][0].isExpanded {
            return 0
        }
        return contacts[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secert", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.section][indexPath.row].tel
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("close", for: .normal)
        button.backgroundColor = UIColor.yellow
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handeleExpend), for: .touchUpInside)
        button.tag = section
        return button
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }

    @objc func handeleExpend (button: UIButton) {
        print("vvvvvvvv")
     let section = button.tag
        let isExpands = contacts[section][0].isExpanded
        contacts[section][0].isExpanded = !isExpands
        
        if isExpands {
            tabelView.insertRows(at: [IndexPath.init(row: 0, section: section)], with: .fade)
        } else {
            tabelView.deleteRows(at: [IndexPath.init(row: 0, section: section)], with: .fade)
        }
       // contacts[section].removeAll()
        
    }
}
