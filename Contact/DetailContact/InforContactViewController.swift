//
//  InforContactsViewController.swift
//  Contact
//
//  Created by Hang on 15/07/2022.
//

import UIKit

protocol EditControllerDelegate {
    func editContact(contact: Contact)
}
typealias callback = (Contact) -> Void
class InforContactViewController: UIViewController {

    var changeDataCalled: callback!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet var setView: [UIView]!
    @IBOutlet weak var imageContact: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewChange: UIView!
    
    @IBOutlet weak var heightOfImageContraint: NSLayoutConstraint!
    var contacts: Contact? {
        didSet {
            if isViewLoaded {
                userName.text = contacts?.lastName
                phoneNumber.text = contacts?.phone
                email.text = contacts?.email
                //imageContact.image = contacts?.image
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(goToEdit))
        setView.forEach({ $0.layer.cornerRadius = 10 })
        scrollView.delegate = self
        scrollView.contentInset = UIEdgeInsets(top: 246, left: 0, bottom: 0, right: 0)
    }
    
    @IBAction func goToEdit(_ sender: Any) {
        let sb = AddInforViewController(nibName: "AddInforViewController", bundle: nil)
        sb.textName = userName.text!
        sb.textPhone = phoneNumber.text!
        sb.textMail = email.text!
        sb.editdelegate = self
        self.navigationController?.pushViewController(sb, animated: true)
    }
    
    @IBAction func myFauvourite(_ sender: Any) {
        print("My Favourites")
    }
    
    @IBAction func shareContact(_ sender: Any) {
        print("Share Contact")
    }
    
    @IBAction func addToEmergency(_ sender: Any) {
        print("Add to emergency contacts")
    }
    
    @IBAction func shareLocation(_ sender: Any) {
        print("Share my location")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        userName.text = contacts!.lastName
        phoneNumber.text = contacts!.phone
        email.text = contacts?.email
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? AddInforViewController else {
            fatalError("Error")
        }
        vc.editdelegate = self
    }
    
    
}

extension InforContactViewController: EditControllerDelegate {
    func editContact(contact: Contact) {
        contacts = contact
        if let dataCallback = changeDataCalled {
            dataCallback(Contact(lastName: contact.lastName, phone: contact.phone, email: contact.email, isSelect: false))
        }
    }
}

extension InforContactViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let oy = scrollView.contentOffset.y
        let height = 100 - oy
        if height <= 50 || height >= 100 {
            return
        }
        heightOfImageContraint.constant = height
    }
}

