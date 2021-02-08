//
//  AddProductVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 04/02/21.
//

import UIKit
import JVFloatLabeledTextField
import InstantSearchVoiceOverlay

class AddProductVC: BaseVC, VoiceOverlayDelegate {

    @IBOutlet weak var textFieldAddProductName: JVFloatLabeledTextField!
    @IBOutlet weak var viewQuantity: UIView!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var viewProductQuantityType: UIView!
    @IBOutlet weak var btnCreateNew: UIButton!
    @IBOutlet weak var viewProductType: UIView!
    @IBOutlet weak var viewDollar: UIView!
    @IBOutlet weak var viewUnitPrice: UIView!
    @IBOutlet weak var textViewNotes: JVFloatLabeledTextView!
    @IBOutlet weak var imageViewAbout: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    
    let voiceOverlay = VoiceOverlayController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Add Product"
        self.setupBackBarButton()
        textFieldAddProductName.setRightPaddingPoints(40)
        UtilityMethods.addBorder(self.btnPlus, .lightGray, 5.0)
        UtilityMethods.addBorder(self.btnMinus, .lightGray, 5.0)
        UtilityMethods.addBorder(self.viewQuantity, .lightGray, 5.0)
        UtilityMethods.addBorder(self.viewProductType, .lightGray, 5.0)
        UtilityMethods.addBorder(self.viewProductQuantityType, .lightGray, 5.0)
        UtilityMethods.addBorder(self.viewUnitPrice, .lightGray, 5.0)
        UtilityMethods.addBorder(self.textViewNotes, .lightGray, 5.0)
        self.btnCreateNew.layer.cornerRadius = 5.0
        self.viewDollar.layer.cornerRadius = 5.0
        self.btnSave.layer.cornerRadius = 5.0
        UtilityMethods.changeImageColor(self.imageViewAbout, .lightGray)
        
        
        self.textFieldAddProductName.floatingLabel.backgroundColor = .white
    }
    
    func recording(text: String?, final: Bool?, error: Error?) {
        
    }
    
//    MARK:- Button Action
    @IBAction func btnMicrophoneTapped(_ sender: UIButton) {
        voiceOverlay.delegate = self
        voiceOverlay.settings.autoStart = true
        voiceOverlay.settings.autoStop = true
        voiceOverlay.settings.autoStopTimeout = 2.0
        
        voiceOverlay.start(on: self) { (text, final, obj) in
            if final {
                self.textFieldAddProductName.text = text
            }
        } errorHandler: { (error) in
            self.showToastWithMessage(error.debugDescription)
        }
        

    }
    
    @IBAction func btnCreateNewCategoryTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnAddProductTapped(_ sender: UIButton) {
        
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
