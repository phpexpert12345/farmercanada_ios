//
//  BaseVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 01/01/21.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    Setup Back Bar Button
    func setupBackBarButton() -> Void {
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: "back")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(buttonBackBarAction(_:)))
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
//    Back Bar Button Action
    @objc func buttonBackBarAction(_ sender : UIButton) -> Void {
        self.navigationController?.popViewController(animated: true)
    }
}
