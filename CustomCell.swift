//
//  CustomCell.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 8.02.2021.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var pImage: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var pPrice: UILabel!
    @IBOutlet weak var pDetail: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
