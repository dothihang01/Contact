//
//  InforContactsViewController.swift
//  Contact
//
//  Created by Hang on 15/07/2022.
//

import UIKit

class InforContactsViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var myTable2: UITableView!
    
    var contact: Contact? {
        didSet {
            if isViewLoaded {
                textLabel.text = contact?.name
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        myTable2.dataSource = self
//        textLabel.text = nameContact
        
    }
}

//extension InforContactsViewController: UITableViewDataSource
//{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return nameContact.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellinfor")
//        cell?.textLabel?.text = phoneContact
//        return cell!
//    }
//}
