//
//  ViewController.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 01/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    var index: NSInteger = 0

    // PRAGMA: actions
    @IBAction func showBadgeHandelr(_: AnyObject) {
        // example for showing badges
        index += 1
        tabBarItem.badgeValue = "\(index)"
    }

    @IBAction func hideBadgeHandler(_: AnyObject) {
        tabBarItem.badgeValue = nil
//        let cartVC = LoginVC.init(nibName: "LoginVC", bundle: nil)
//        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

