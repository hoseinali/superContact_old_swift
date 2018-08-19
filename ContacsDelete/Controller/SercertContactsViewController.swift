

import UIKit


class SercertContactsViewController: UIViewController,UITableViewDelegate , UITableViewDataSource {

    
    var hiddenContacts = [HiddenContact]()
    var t_count:Int = 0
    var lastCell = HiddenContactCell()
    var button_tag:Int = -1
    var tableview:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // for example
       hiddenContacts.append(HiddenContact.init(name: "hosein", tel: "093334544", email: nil))
        hiddenContacts.append(HiddenContact.init(name: "ali", tel: "3434567", email: nil))
        tableview = UITableView.init(frame: view.frame)
        tableview.layer.frame.size.height = view.frame.height * 1.5
        tableview.frame.origin.y += 125
        tableview.register(UINib.init(nibName: "HiddenContactCell", bundle: nil), forCellReuseIdentifier: "hiddenContact")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.allowsSelection = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor.green
        view.addSubview(tableview)


    }
    
}

// MARK: - TableView

extension SercertContactsViewController {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    

}

