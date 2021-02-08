//
//  SuccessPopView.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit
import Foundation

protocol SuccessPopupActionDelegate : class {
    func btnOkAction(_ sender: UIButton)
}

@IBDesignable
class SuccessPopView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnOK: UIButton!
    
    weak var delegate : SuccessPopupActionDelegate?
    
    @IBInspectable
        var cornerRadius: CGFloat {
            set { layer.cornerRadius = newValue }
            get { return layer.cornerRadius     }
        }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
    
    func commonInit() -> Void {
        let viewFromXib = Bundle.main.loadNibNamed("SuccessPopupView", owner: self, options: nil)?.first as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    @IBAction func btnOkTapped(_ sender: UIButton) {
        self.delegate?.btnOkAction(sender)
    }
}
