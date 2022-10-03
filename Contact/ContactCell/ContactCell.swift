//
//  ContactCell.swift
//  Contact
//
//  Created by Hang on 22/08/2022.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var checkBox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func checkBox(_ sender: Any) {
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
