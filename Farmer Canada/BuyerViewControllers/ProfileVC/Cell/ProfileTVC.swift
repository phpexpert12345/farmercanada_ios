//
//  ProfileTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 13/01/21.
//

import UIKit

class ProfileTVC: UITableViewCell {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var lblProfileTitle: UILabel!
    @IBOutlet weak var imageViewForwardArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UtilityMethods.changeImageColor(self.imageViewForwardArrow, .lightGray)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
