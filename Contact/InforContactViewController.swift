//
//  InforContactsViewController.swift
//  Contact
//
//  Created by Hang on 15/07/2022.
//

import UIKit

typealias callback = (Contact) -> Void
class InforContactViewController: UIViewController {
    
    var changeDataCalled: callback?
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    var contacts: Contact? {
        didSet {
            if isViewLoaded {
                textLabel.text = contacts?.name
                phoneNumber.text = contacts?.phone
                email.text = contacts?.email
            }
        }
    }

    @IBAction func editContact(_ sender: Any) {
        let sb = EditContactViewController(nibName: "editContactViewController", bundle: nil)
        sb.textName = textLabel.text!
        sb.textPhone = phoneNumber.text!
        sb.editdelegate = self
        self.navigationController?.pushViewController(sb, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textLabel.text = contacts!.name
        phoneNumber.text = contacts!.phone
        email.text = contacts?.email
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? EditContactViewController else {
            fatalError("Error")
        }
        vc.editdelegate = self
    }
}

extension InforContactViewController: EditControllerDelegate {
    func editContact(contact: Contact) {
        contacts = contact
        if let dataCallback = changeDataCalled {
            dataCallback(Contact(name: contact.name, phone: contact.phone, email: contact.email))
        }
        print("abckdf")
    }
}

