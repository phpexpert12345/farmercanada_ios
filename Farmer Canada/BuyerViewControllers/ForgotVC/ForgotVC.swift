//
//  ForgotVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 05/01/21.
//

import UIKit
import JVFloatLabeledTextField

class ForgotVC: BaseVC {

    @IBOutlet weak var txtFieldPhoneNumber: JVFloatLabeledTextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnSubmit)
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Forgot Password"
        self.setupBackBarButton()
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.setTitleColor(.white, for: .normal)
        self.btnSubmit.backgroundColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.txtFieldPhoneNumber.floatingLabel.backgroundColor = .white
    }
}
