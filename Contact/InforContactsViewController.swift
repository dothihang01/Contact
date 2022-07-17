//
//  InforContactsViewController.swift
//  Contact
//
//  Created by Hang on 15/07/2022.
//

import UIKit

class InforContactsViewController: UIViewController, UITableViewDataSource {

    var nameContact: String = ""
    var phoneContact: String = ""
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var myTable2: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable2.dataSource = self
       textLabel.text = nameContact
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneContact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellinfor")
        cell?.textLabel?.text = phoneContact
        return cell!
    }
    

}

