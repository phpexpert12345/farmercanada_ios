//
//  ItemCVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 10/01/21.
//

import UIKit

class ItemCVC: UICollectionViewCell {

    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var viewNotify: UIView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var viewQuantity: UIView!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var imageViewArrow: UIImageView!
    @IBOutlet weak var viewAddToCart: UIView!
    @IBOutlet weak var viewOutOfStock: UIView!
    @IBOutlet weak var imageViewAbout: UIImageView!
    @IBOutlet weak var imageViewNotify: UIImageView!
    
    var dropdownQuantity = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        UtilityMethods.changeImageColor(self.imageViewArrow, .darkGray)
        UtilityMethods.changeImageColor(self.imageViewNotify, .white)
        UtilityMethods.changeImageColor(self.imageViewNotify, Colors.colorWithHexString(Colors.BUTTON_COLOR))
        UtilityMethods.changeImageColor(self.imageViewAbout, Colors.colorWithHexString(Colors.BUTTON_COLOR))
        UtilityMethods.addBorder(self.viewQuantity, .lightGray, 3.0)
        self.viewOutOfStock.layer.borderWidth = 0.5
        self.viewOutOfStock.layer.borderColor = Colors.colorWithHexString(Colors.APP_COLOR).cgColor
        self.viewOutOfStock.layer.cornerRadius = 5.0
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
        self.setupQuantityDropdown()
    }
    
    func setupQuantityDropdown() -> Void {
        self.dropdownQuantity.anchorView = self.viewQuantity
        self.dropdownQuantity.direction = .any
        self.dropdownQuantity.dataSource = ["2kg", "5kg", "10kg", "15kg", "20kg"]
        self.dropdownQuantity.bottomOffset = CGPoint(x: 0, y:((self.dropdownQuantity.anchorView?.plainView.bounds.height)! + 10))
        self.dropdownQuantity.topOffset = CGPoint(x: 0, y:-((self.dropdownQuantity.anchorView?.plainView.bounds.height)! + 10))
        self.dropdownQuantity.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)", self)
            self.lblQuantity.text = item
        }
        self.dropdownQuantity.width = self.viewQuantity.bounds.width
        self.dropdownQuantity.cellHeight = 40
    }

//    MARK:- Button Action
    @IBAction func btnAddToCartTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnOutOfStockTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnQuantityTapped(_ sender: UIButton) {
        self.dropdownQuantity.show()
    }
}
