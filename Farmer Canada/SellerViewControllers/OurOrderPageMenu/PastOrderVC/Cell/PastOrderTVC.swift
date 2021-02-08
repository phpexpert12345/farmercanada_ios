//
//  PastOrderTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 26/01/21.
//

import UIKit

class PastOrderTVC: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnViewDetails: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UtilityMethods.addBorder(self.btnViewDetails, Colors.colorWithHexString(Colors.SELLER_APP_COLOR), 3.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
