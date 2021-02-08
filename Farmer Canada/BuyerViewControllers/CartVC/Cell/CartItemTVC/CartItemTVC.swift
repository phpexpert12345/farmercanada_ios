//
//  CartItemTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 10/01/21.
//

import UIKit

class CartItemTVC: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductDes: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnMinus.titleEdgeInsets = UIEdgeInsets(top: -2.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.btnplus.titleEdgeInsets = UIEdgeInsets(top: -2.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.viewCount.layer.cornerRadius = self.viewCount.bounds.height/2
        self.viewCount.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
