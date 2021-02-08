//
//  AboutStoreVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 16/01/21.
//

import UIKit

class AboutStoreVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "About Store"
        self.setupBackBarButton()
        self.setupNotificationNavBarButton()
    }
}
