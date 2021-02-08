//
//  ReviewedTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 16/01/21.
//

import UIKit
import Cosmos

class ReviewedTVC: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMessageCount: UILabel!
    @IBOutlet weak var imageViewUser: UIImageView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageViewUser.layer.cornerRadius = self.imageViewUser.bounds.height/2
        self.imageViewUser.layer.masksToBounds = true
        self.viewRating.isUserInteractionEnabled = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
