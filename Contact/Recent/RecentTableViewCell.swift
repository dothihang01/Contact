//
//  RecentTableViewCell.swift
//  Contact
//
//  Created by Hang on 22/08/2022.
//

import UIKit

class RecentTableViewCell: UITableViewCell {

    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var useName: UILabel!
    @IBOutlet weak var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
