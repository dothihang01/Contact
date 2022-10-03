//
//  ViewController.swift
//  Contact
//
//  Created by Hang on 14/07/2022.
//

import UIKit

class ContactViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var searchContact: UISearchBar!
    @IBOutlet weak var countContacts: UILabel!
    
    var listContact = [Contact]()
    var listContactDisplay: [ContactSession] = []
    var filterData: [ContactSession] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.dataSource = self
        myTable.delegate = self
        searchContact.delegate = self
        createContacts()
        myTable.reloadData()
        myTable.allowsMultipleSelectionDuringEditing = true
        self.myTable.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "cell")
//        getdata {
//            self.updateContactsDisplay()
//            self.myTable.reloadData()
//        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(goSort))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("kAddContact"), object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        let contact = notification.userInfo?["contact"] ?? Contact(lastName: "", phone: "", email: "", isSelect: false)
        listContact.append(contact as! Contact)
        updateContactsDisplay()
        myTable.reloadData()
    }
    
    
    @IBAction func goToAddContact(_ sender: Any) {
        let viewController = AddInforViewController()
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func goSort(_ sender: UIBarButtonItem) {

        self.myTable.isEditing = !self.myTable.isEditing
        myTable.reloadData()
    }
    
    func createContacts() {
        listContact.append(Contact(firstName: "", lastName: "Hoang", phone: "0346310004", email: "a@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "", lastName: "Chang", phone: "0346310004", email: "b@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "Anh", lastName: "Chien", phone: "0346310004", email: "c@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "Binh", lastName: "Chung", phone: "0346310004", email: "d@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "Duong", lastName: "Huy", phone: "0346310004", email: "e@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "Anh", lastName: "Duy", phone: "123456789", email: "Ha Noi", isSelect: false))
        listContact.append(Contact(firstName: "Huong", lastName: "Duong", phone: "0346310004", email: "f@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "Hoa", lastName: "Yen", phone: "0346310004", email: "g@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "Thuy", lastName: "Yueng", phone: "0346310004", email: "j@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "Nam", lastName: "Trang", phone: "0346310004", email: "k@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "875", lastName: "Hoang", phone: "0346310004", email: "l@gmail.com", isSelect: false))
        listContact.append(Contact(firstName: "0947", lastName: "Huong", phone: "123456789", email: "Ha Nam", isSelect: false))
        updateContactsDisplay()
        }

//    func getdata(completed: @escaping () -> ()) {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/users")
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//                if error == nil {
//                    do {
//                        self.listContact = try JSONDecoder().decode([Contact].self, from: data!)
//                        DispatchQueue.main.async {
//                        completed()
//                    }
//                }
//                catch {
//                    print("JSON ERROR")
//                }
//            }
//        }.resume()
//    }
        
    func updateContactsDisplay() {
        var dataDisplay: [ContactSession] = []
        let contactSessionNumber = ContactSession(title: "#", contacts: [])
        let listPreCharator = listContact.map{ $0.lastName.prefix(1).uppercased() }.removingDuplicates()
        for char in listPreCharator {
            let contactSession = ContactSession(title: String(char), contacts: [])
            if Character(char).isNumber {
                for contact in listContact {
                    if contact.lastName.prefix(1).lowercased() == char.lowercased() {
                        contactSessionNumber.contacts.append(contact)
                    }
                }
            }
            else {
                for contact in listContact {
                    if contact.lastName.prefix(1).lowercased() == char.lowercased() {
                        contactSession.contacts.append(contact)
                    }
                }
                dataDisplay.append(contactSession)
            }
        }
        if contactSessionNumber.contacts.isEmpty {
            contactSessionNumber.title.removeAll()
        } else {
            dataDisplay.append(contactSessionNumber)
        }
        if myTable.isEditing {
            return
        } else {
            self.listContactDisplay = dataDisplay.sorted(by: { $0.title < $1.title })
        }
        if listContactDisplay[0].title == "#" {
            let element = listContactDisplay.remove(at: 0)
            listContactDisplay.insert(element, at: listContactDisplay.count)
        }

        self.countContacts.text = "\(self.listContact.count) contacts"
        myTable.reloadData()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddInforViewController else {
            fatalError("Error")
        }
        vc.delegate = self
    }
}

extension ContactViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listContactDisplay.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listContactDisplay[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactCell
        cell.name.text = self.listContactDisplay[indexPath.section].contacts[indexPath.row].lastName
        return cell
    }
                
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.listContactDisplay[section].title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var listTitle = [String]()
        for list in listContactDisplay {
            listTitle.append(list.title)
        }
        return listTitle
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveObjTemp = listContactDisplay[sourceIndexPath.section].contacts[sourceIndexPath.row]
        listContactDisplay[sourceIndexPath.section].contacts.remove(at: sourceIndexPath.row)
        listContactDisplay[sourceIndexPath.section].contacts.insert(moveObjTemp, at: destinationIndexPath.row)
        updateContactsDisplay()
    }
}

// SHOW SEARCH CONTACTS
extension ContactViewController {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData.removeAll()
        var temp:[Contact] = []
        if searchText == "" {
            filterData = listContactDisplay
            countContacts.text = "\(listContact.count) contacts"
            updateContactsDisplay()
            self.myTable.reloadData()
        }
        else {
            for contact in listContact {
                if contact.lastName.lowercased().contains(searchText.lowercased()) {
                    temp.append(contact)
                }
            }
            filterData.append(ContactSession(title: "", contacts: temp))
            listContactDisplay = filterData
            self.myTable.reloadData()
            countContacts.text = "\(temp.count) contacts"
        }
    }
}

extension ContactViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

         let contactDetailVC = InforContactViewController(nibName: "InforContactViewController", bundle: nil)

         contactDetailVC.contacts = self.listContactDisplay[indexPath.section].contacts[indexPath.row]
        if self.myTable.isEditing {
            print(contactDetailVC.contacts!.lastName)
            
            return
        }
        self.navigationController?.pushViewController(contactDetailVC, animated: true)
         contactDetailVC.changeDataCalled = {
             newData in
             print("newData \(newData.lastName)")
             self.listContactDisplay[indexPath.section].contacts[indexPath.row] = newData
//             self.updateContactsDisplay()
             self.myTable.reloadData()
             
        }
    }
    
    // DELETE CONTACTS
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listContactDisplay[indexPath.section].contacts.remove(at: indexPath.row)
            myTable.deleteRows(at: [indexPath], with: .automatic)
        }
        if listContactDisplay[indexPath.section].contacts.count == 0 {
            listContactDisplay.remove(at: indexPath.section)
        }
        
        myTable.reloadData()
    }
}

extension Array where Element: Equatable {
    func removingDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}

extension ContactViewController: AddContactViewControllerDelegate {
    func addItemContact(contact: Contact) {
        listContact.append(contact)
        updateContactsDisplay()
        myTable.reloadData()
    }
}

