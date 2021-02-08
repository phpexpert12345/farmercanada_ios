//
//  FarmCVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 08/01/21.
//

import UIKit

class FarmCVC: UICollectionViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imageViewFarm: UIImageView!
    @IBOutlet weak var lblFarmName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblFollow: UILabel!
    @IBOutlet weak var imageViewFollow: UIImageView!
    @IBOutlet weak var viewRatingBg: UIView!
    @IBOutlet weak var viewFollow: UIView!
    @IBOutlet weak var btnSaveFarm: UIButton!
    
    var indexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.lblFollow.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
//        self.viewFollow.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
        self.imageViewFollow.layer.cornerRadius = self.imageViewFollow.bounds.height/2
        self.imageViewFollow.layer.masksToBounds = true
        self.viewFollow.layer.cornerRadius = 3.0
        self.viewRatingBg.layer.cornerRadius = self.viewRatingBg.bounds.height/2
        self.viewBg.layer.cornerRadius = 5.0
        UtilityMethods.addShadow(self.viewBg)
        
        self.frame = CGRect.init(x: self.bounds.origin.x, y: self.bounds.origin.y, width: (UIScreen.main.bounds.width-45)/2, height: self.bounds.height)
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

    @IBAction func btnSaveTapped(_ sender: UIButton) {
        
    }
}
