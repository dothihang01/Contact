//
//  RecentsViewController.swift
//  Contact
//
//  Created by Hang on 12/08/2022.
//

import UIKit

enum RecentType {
    case all
    case missed
}

class RecentsViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var recentsTableView: UITableView!
    var listcontactRecents: [ContactRecents] = []
    var listCallMissed: [ContactRecents] = []
    //var type: RecentType = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentsTableView.dataSource = self
        createContacts()
        getMissed()
        recentsTableView.reloadData()
        recentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.recentsTableView.register(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        listcontactRecents.sort(by: {$0.date < $1.date})
        listCallMissed.sort(by: {$0.date <  $1.date})
    }
    
    func createContacts() {
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "", phone: "093545867", isSelect: false), date: "Tuesday", status: "missed"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "Hoa", phone: "084573756", isSelect: false), date: "Tuesday", status: "received"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "Binh ", phone: "0945875684", isSelect: false), date: "Monday", status: "incoming"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "093545867 ", phone: "09345877457", isSelect: false), date: "Yesterday", status: "received"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "Binh ", phone: "0945875684", isSelect: false), date: "Friday", status: "missed"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "", phone: "048756475", isSelect: false), date: "1 hour", status: "missed"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "Thuong ", phone: "0237434554", isSelect: false), date: "Sunday", status: "incoming"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "Mai", phone: "02837454456", isSelect: false), date: "Thursday", status: "missed"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "Hai", phone: "0287458345", isSelect: false), date: "Tuesday", status: "incoming"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "Thanh", phone: "0384755555", isSelect: false), date: "Yesterday", status: "received"))
        listcontactRecents.append(ContactRecents(contacts: Contact(lastName: "Thuy", phone: "0128273726", isSelect: false), date: "2 hours", status: "missed"))
    }
    
    func getMissed() {
        for recent in listcontactRecents {
            if recent.status == "missed" {
                listCallMissed.append(recent)
            }
        }
    }
    @IBAction func segmentedChange(_ sender: Any) {
        recentsTableView.reloadData()
    }
    
    func shareRecentType(on platform: RecentType) -> [ContactRecents] {
        switch platform {
        case .all:
            return listcontactRecents
        case .missed:
            return listCallMissed
        }
    }
}

extension RecentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return shareRecentType(on: .all).count
        case 1:
            return shareRecentType(on: .missed).count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recents"
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecentTableViewCell
        cell.useName.textColor = UIColor.black
        cell.imageStatus.image = UIImage(systemName: "")
        cell.imageStatus.tintColor = .systemBlue

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if listcontactRecents[indexPath.row].contacts.lastName == "" {
                cell.useName.text = listcontactRecents[indexPath.row].contacts.phone
            } else {
                cell.useName.text = listcontactRecents[indexPath.row].contacts.lastName
            }
            cell.time.text = listcontactRecents[indexPath.row].date
            cell.useName.textColor = UIColor.blue
            if listcontactRecents[indexPath.row].status == "missed" {
                cell.useName.textColor = UIColor.red
                cell.imageStatus.image = UIImage(systemName: "phone.fill.arrow.down.left")
                cell.imageStatus.tintColor = .systemRed
            }
            if listcontactRecents[indexPath.row].status == "received" {
                cell.imageStatus.image = UIImage(systemName: "phone.fill.arrow.up.right")
            }
            if listcontactRecents[indexPath.row].status == "incoming" {
                cell.imageStatus.image = UIImage(systemName: "phone.fill.arrow.down.left")
            }
        case 1:
            if listCallMissed[indexPath.row].contacts.lastName == "" {
                cell.useName.text = listCallMissed[indexPath.row].contacts.phone
            } else {
                cell.useName.text = listCallMissed[indexPath.row].contacts.lastName
            }
            cell.useName.textColor = UIColor.red
                cell.imageStatus.image = UIImage(systemName: "phone.fill.arrow.down.left")
            cell.imageStatus.tintColor = .systemRed
            cell.time.text = listCallMissed[indexPath.row].date
        default:
            break
        }
        return cell
    }
}
