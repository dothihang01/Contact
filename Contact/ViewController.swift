//
//  ViewController.swift
//  Contact
//
//  Created by Hang on 14/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTable: UITableView!
    
    var name: String!
    
    var listContact: [Contact] = []
//    var contactsDict = [String: [String]]()
//    var contactSection = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        createContacts()
//        myTable.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        name = nil
//        print(name)
    }
    
    func createContacts() {
        listContact.append(Contact(name: "Hoang", phone: "0346310004"))
        listContact.append(Contact(name: "Em", phone: "0346310004"))
        listContact.append(Contact(name: "Anh", phone: "0346310004"))
        listContact.append(Contact(name: "Binh", phone: "0346310004"))
        listContact.append(Contact(name: "Cuong", phone: "0346310004"))
        listContact.append(Contact(name: "Fhu", phone: "123456789", address: "Ha Noi"))
        
    }
    
    @IBAction func didSelectAddContact(_ sender: Any) {
        listContact.insert(Contact(name: "ABC", phone: "123456"), at: 0)
        myTable.reloadData()
    }
}

extension ViewController: UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listContact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listContact[indexPath.row].name
        return cell
    }
}

extension ViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let contactDetailVC = sb.instantiateViewController(withIdentifier: "inforContacts") as! InforContactsViewController
        self.navigationController?.pushViewController(contactDetailVC, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            contactDetailVC.contact = self.listContact[indexPath.row]
        }
    }
}
