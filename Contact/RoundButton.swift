//
//  RoundButton.swift
//  Contact
//
//  Created by Hang on 09/08/2022.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var roundButton: Bool = false {
        didSet {
            if roundButton {
                layer.cornerRadius = 25
            }
        }
    }
}
