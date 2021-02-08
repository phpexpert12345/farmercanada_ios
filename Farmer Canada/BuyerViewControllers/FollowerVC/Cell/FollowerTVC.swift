//
//  FollowerTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit

class FollowerTVC: UITableViewCell {

    @IBOutlet weak var imageViewFarm: UIImageView!
    @IBOutlet weak var lblFarmName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imageViewFollow: UIImageView!
    @IBOutlet weak var viewUnfollow: UIView!
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewUnfollow.layer.cornerRadius = 3.0
        UtilityMethods.changeImageColor(self.imageViewFollow, .black)
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
