//
//  OngoingOrderTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 26/01/21.
//

import UIKit

class OngoingOrderTVC: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewDropdownOrderStatus: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewDropdownOrderStatus.layer.cornerRadius = 3.0
        self.viewDropdownOrderStatus.layer.borderWidth = 0.5
        self.viewDropdownOrderStatus.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
