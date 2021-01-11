//
//  CategoryCVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 08/01/21.
//

import UIKit

class CategoryCVC: UICollectionViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var imageViewCategory: UIImageView!
    @IBOutlet weak var imageViewBg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewBg.layer.cornerRadius = 3.0
    }

}
