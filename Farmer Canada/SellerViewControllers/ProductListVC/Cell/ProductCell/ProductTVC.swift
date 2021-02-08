//
//  ProductTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 04/02/21.
//

import UIKit

class ProductTVC: UITableViewCell {

    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPriceTotal: UILabel!
    @IBOutlet weak var lblPriceUnit: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblQuality: UILabel!
    @IBOutlet weak var lblCouponAmount: UILabel!
    @IBOutlet weak var viewCouponCode: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var viewDelete: UIView!
    @IBOutlet weak var viewEdit: UIView!
    @IBOutlet weak var imageViewEdit: UIImageView!
    @IBOutlet weak var lblCouponCode: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UtilityMethods.changeImageColor(self.imageViewEdit, .white)
        self.viewEdit.layer.cornerRadius = 5.0
        self.viewDelete.layer.cornerRadius = 5.0
        self.viewEdit.backgroundColor = Colors.colorWithHexString(Colors.SELLER_APP_COLOR)
        self.lblPriceTotal.textColor = Colors.colorWithHexString(Colors.SELLER_APP_COLOR)
        self.lblPriceUnit.textColor = Colors.colorWithHexString(Colors.SELLER_APP_COLOR)
        self.lblCouponCode.textColor = Colors.colorWithHexString(Colors.SELLER_APP_COLOR)
        UtilityMethods.addBorder(self.viewCouponCode, Colors.colorWithHexString(Colors.SELLER_APP_COLOR), 3.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
