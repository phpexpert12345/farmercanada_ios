//
//  AddAddressVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit
import CNPPopupController
import JVFloatLabeledTextField

class AddAddressVC: BaseVC, CNPPopupControllerDelegate, SuccessPopupActionDelegate {
    func btnOkAction(_ sender: UIButton) {
        self.popupController?.dismiss(animated: true)
    }

    @IBOutlet weak var textFieldCityName: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldTitleName: JVFloatLabeledTextField!
    @IBOutlet weak var textFieldAddressLine: JVFloatLabeledTextField!
    @IBOutlet weak var textViewCompleteAddress: JVFloatLabeledTextView!
    @IBOutlet weak var textFieldLandmark: JVFloatLabeledTextField!
    @IBOutlet weak var btnSave: UIButton!
    
    var popupController:CNPPopupController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnSave)
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Add Address"
        self.setupBackBarButton()
        self.setupNotificationNavBarButton()
        self.textFieldCityName.floatingLabel.backgroundColor = .white
        self.textFieldTitleName.floatingLabel.backgroundColor = .white
        self.textFieldLandmark.floatingLabel.backgroundColor = .white
        self.textFieldAddressLine.floatingLabel.backgroundColor = .white
        self.textViewCompleteAddress.floatingLabel.backgroundColor = .white
        self.textViewCompleteAddress.layer.cornerRadius = 5.0
        UtilityMethods.addBorder(self.textViewCompleteAddress, .lightGray, 5.0)
        self.btnSave.layer.cornerRadius = 5.0
    }
    
    var popupView = SuccessPopView()
    func setupPopupView() -> Void {
        self.popupView = SuccessPopView.init(frame: CGRect.init(x: 15, y: 0, width: self.screenWidth-30, height: 250))
        self.popupView.viewContainer.layer.cornerRadius = 10.0
        self.popupView.delegate = self
        self.popupView.btnOK.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.popupView.lblTitle.text = "Your Address saved"
        self.popupView.lblMessage.text = "Your Address has been saved successfully."

        let popupController = CNPPopupController(contents:[self.popupView])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = CNPPopupStyle.centered
        // LFL added settings for custom color and blur
        popupController.theme.backgroundColor = .clear
        popupController.theme.maskType = .dimmed
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }
    
//    MARK:- Button Action
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        self.setupPopupView()
    }
}
