//
//  KeyBoardViewController.swift
//  Contact
//
//  Created by Hang on 10/08/2022.
//

import UIKit

class KeyBoardViewController: UIViewController {
    

    @IBOutlet weak var outputLbl: UILabel!
    
    @IBOutlet var roundButton: [RoundButton]!
    @IBOutlet var actionNumbers: [RoundButton]!
    @IBOutlet weak var AddPhoneNumber: UIButton!
    var phoneNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.leadingConstraint.constant = 70
            AddPhoneNumber.isHidden = true
    }
    
    @IBAction func AddNumber(_ sender: Any) {
        let vc = AddInforViewController(nibName: "AddInforViewController", bundle: nil)
        vc.textPhone = phoneNumber
        self.navigationController!.pushViewController(vc, animated: true)
        print(vc.lastName as Any, vc.email as Any)
    }
    
    @IBAction func numbersPress(_ sender: RoundButton) {
        phoneNumber += "\(sender.tag)"
        outputLbl.text = phoneNumber
        AddPhoneNumber.isHidden = false
    }
    
    @IBAction func esterisk(_ sender: RoundButton) {
        phoneNumber += "*"
        outputLbl.text = phoneNumber
        AddPhoneNumber.isHidden = false
    }
    
    @IBAction func hashtag(_ sender: RoundButton) {
        phoneNumber += "#"
        outputLbl.text = phoneNumber
        AddPhoneNumber.isHidden = false
    }
    
    @IBAction func deleteACharater(_ sender: RoundButton) {
        outputLbl.text = String(outputLbl.text!.dropLast())
        phoneNumber = outputLbl.text!
        if phoneNumber == "" {
            AddPhoneNumber.isHidden = true
        }
    }
    
    func someAction(sender: UIButton) {
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.lightGray.cgColor
        colorAnimation.duration = 0.5
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
    }
    
}
