//
//  editContactViewController.swift
//  Contact
//
//  Created by Hang on 09/08/2022.
//

import UIKit
//protocol EditControllerDelegate {
//    func editContact(contact: Contact)
//}

class EditContactViewController: UIViewController {
    //var editdelegate: EditControllerDelegate?
    var editdelegate: EditControllerDelegate?
    @IBOutlet weak var editPhone: UITextField!
    @IBOutlet weak var editName: UITextField!
    var textName: String = ""
    var textPhone: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        editName?.text = textName
        editPhone?.text = textPhone
    }

    @IBAction func updateContact(_ sender: Any) {
        editdelegate?.editContact(contact: Contact(lastName: editName.text!, phone: editPhone.text!, isSelect: false))
        navigationController?.popViewController(animated: true)
    }
    
}
