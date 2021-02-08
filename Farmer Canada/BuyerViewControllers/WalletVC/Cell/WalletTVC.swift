//
//  WalletTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 18/01/21.
//

import UIKit

class WalletTVC: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewWalletBg: UIView!
    @IBOutlet weak var lblFarmName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imageViewWallet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
