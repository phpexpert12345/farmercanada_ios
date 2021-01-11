//
//  ItemListTVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 10/01/21.
//

import UIKit

class ItemListTVC: UITableViewCell {

    @IBOutlet weak var lblProductCategory: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
