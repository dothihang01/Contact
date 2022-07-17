//
//  ViewController.swift
//  Contact
//
//  Created by Hang on 14/07/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTable:
    UITableView!
    var arrayContacts: [(name: String, phone: String)] = [("Anh","0192374839"),("Thuy","0283746512"),("Huong","0743284736"),("Hoa","0193728463"),("Nam","0183649384"),("Phong","0912847364")]
    
    var contactsDict = [String: [String]]()
    var contactSection = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        createContactsDict()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactSection[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contactKey = contactSection[section]
        guard let contactValue = contactsDict[contactKey] else {return 0}
        return contactValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contactKey = contactSection[indexPath.section]
        if let contactValue = contactsDict[contactKey] {
            cell.textLabel?.text = contactValue[indexPath.row]
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let inforcontacts = sb.instantiateViewController(withIdentifier: "inforContacts") as! InforContactsViewController
        let contactKey = contactSection[indexPath.section]
        if let contactValue = contactsDict[contactKey] {
            inforcontacts.nameContact = contactValue[indexPath.row]
            for index in arrayContacts {
                if contactValue[indexPath.row] == index.name {
                    inforcontacts.phoneContact = index.phone
                }
            }
        }
        self.navigationController?.pushViewController(inforcontacts, animated: true)
    }

// FUNCTION GET FIRST CHARACTER.
    func createContactsDict() {
        for contact in arrayContacts {
            let firstCharacterName = contact.name.index(contact.name.startIndex, offsetBy: 1)
            let contactKey  = String(contact.name[..<firstCharacterName])
            if var contactsValue = contactsDict[contactKey] {
                contactsValue.append(contact.name)
                contactsDict[contactKey] = contactsValue
            } else {
                contactsDict[contactKey] = [contact.name]
            }
        }
        contactSection = [String](contactsDict.keys)
        contactSection = contactSection.sorted(by: { $0 < $1 })
    }
   

}

