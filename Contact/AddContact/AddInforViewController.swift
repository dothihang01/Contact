//
//  AddInforViewController.swift
//  Contact
//
//  Created by Hang on 22/07/2022.
//

import UIKit

protocol AddContactViewControllerDelegate {
    func addItemContact(contact: Contact)
}

class AddInforViewController: UIViewController {
    var delegate: AddContactViewControllerDelegate?
    var editdelegate: EditControllerDelegate?
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var Company: UITextField!
    @IBOutlet var viewDecorate: [UIView]!
    @IBOutlet weak var choosedPhoto: UIImageView!
    
    var textPhone = ""
    var textName = ""
    var textMail = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.text! = textPhone
        lastName.text! = textName
        email!.text = textMail
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveContact))
        viewDecorate.forEach{ $0.addBottomBorderLineWithColor(color: .gray, width: 0.5) }
        self.choosedPhoto.layer.cornerRadius = choosedPhoto.frame.height / 2
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    @IBAction func saveContact(_ sender: Any) {
        print(phone.text!)
        print(lastName.text!)
        if delegate != nil {
            if phone.text!.count < 14 {
                if lastName.text!.isEmpty && phone.text!.isEmpty {
                    displayMyAlertMessage(userMessage: "Please enter full information")
                }
                delegate?.addItemContact(contact: Contact(lastName: !lastName.text!.isEmpty ? lastName.text! : phone.text!, phone: phone.text!, email: email.text!, isSelect: false))
            }
        } else if editdelegate != nil {
            if phone.text!.count < 14 {
                if lastName.text!.isEmpty && phone.text!.isEmpty {
                    displayMyAlertMessage(userMessage: "Please enter full information")
                }
                editdelegate?.editContact(contact: Contact(lastName: !lastName.text!.isEmpty ? lastName.text! : phone.text!, phone: phone.text!, email: email.text!, isSelect: false))
                }
        }
        else {
            self.tabBarController?.selectedIndex = 0
            NotificationCenter.default.post(name: Notification.Name("kAddContact"), object: nil, userInfo: ["contact": Contact(lastName: !lastName.text!.isEmpty ? lastName.text! : phone.text! , phone: !phone.text!.isEmpty ? phone.text! : "", email: email.text, isSelect: false)])
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func displayMyAlertMessage(userMessage:String){

        let myAlert = UIAlertController(title: "ERROR", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
     }
    
}
extension UITextField {
func addBottomBorder(){
      let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 0.5)
      bottomLine.backgroundColor = UIColor.gray.cgColor
      borderStyle = .none
      layer.addSublayer(bottomLine)
    }
}

extension UIView {
    func addBottomBorderLineWithColor(color: UIColor, width: CGFloat) {
        let bottomBorderLine = CALayer()
        bottomBorderLine.backgroundColor = color.cgColor
        bottomBorderLine.frame = CGRect(x: 0, y: self.frame.size.height - width , width: self.frame.size.width, height: width )
        self.layer.addSublayer(bottomBorderLine)
    }
}

extension AddInforViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            choosedPhoto.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
