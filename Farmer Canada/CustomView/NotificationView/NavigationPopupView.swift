//
//  NavigationPopupView.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 14/01/21.
//

import Foundation
import UIKit

protocol NotificationPopupActionDelegate : class {
    func btnRemoveViewAction(_ sender: UIButton)
    func switchNotifyNewChatAction(_ sender: UISwitch)
    func switchNotifyAddedFarmAction(_ sender: UISwitch)
    func switchNotifyNewProductAction(_ sender: UISwitch)
    func switchNotifyStockProductAction(_ sender: UISwitch)
}

@IBDesignable
class NavigationPopupView: UIView {
    
    @IBOutlet weak var switchNewChat: UISwitch!
    @IBOutlet weak var switchAddedFarm: UISwitch!
    @IBOutlet weak var switchNewProduct: UISwitch!
    @IBOutlet weak var switchStockProduct: UISwitch!
    @IBOutlet weak var btnRemoveView: UIButton!
    
    weak var delegate : NotificationPopupActionDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
    
    func commonInit() -> Void {
        let viewFromXib = Bundle.main.loadNibNamed("NavigationPopupView", owner: self, options: nil)?.first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
//    MARK:- Switch Action
    @IBAction func switchNotifyNewChatTapped(_ sender: UISwitch) {
        self.delegate?.switchNotifyNewChatAction(sender)
    }
    
    @IBAction func switchNotifyAddedFarmTapped(_ sender: UISwitch) {
        self.delegate?.switchNotifyAddedFarmAction(sender)
    }
    
    @IBAction func switchNotifyNewProductTapped(_ sender: UISwitch) {
        self.delegate?.switchNotifyNewProductAction(sender)
    }
    
    @IBAction func switchNotifyStockProductTapped(_ sender: UISwitch) {
        self.delegate?.switchNotifyStockProductAction(sender)
    }
    
    @IBAction func btnRemovePopupTapped(_ sender: UIButton) {
        self.delegate?.btnRemoveViewAction(sender)
    }
}
