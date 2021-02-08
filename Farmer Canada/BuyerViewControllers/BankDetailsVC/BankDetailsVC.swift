//
//  BankDetailsVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 18/01/21.
//

import UIKit

class BankDetailsVC: BaseVC {

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
        self.navigationItem.title = "Enter Account Details"
        self.setupBackBarButton()
        self.setupNotificationNavBarButton()
    }
}
