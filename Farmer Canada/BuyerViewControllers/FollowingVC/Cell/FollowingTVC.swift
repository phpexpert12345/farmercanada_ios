//
//  FollowingTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit

class FollowingTVC: UITableViewCell {
    
    @IBOutlet weak var lblFarmName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imageViewFarm: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UtilityMethods.addBorder(self.imageViewFarm, .lightGray, self.imageViewFarm.bounds.height/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    MARK:- Button Action
    @IBAction func btnUnfollowTapped(_ sender: UIButton) {
        
    }
}
