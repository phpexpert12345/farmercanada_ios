//
//  AddAddressTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit

class AddAddressTVC: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddressMark: UILabel!
    @IBOutlet weak var lblAddressDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.viewLocation.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
