//
//  ReviewPageMenuVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 16/01/21.
//

import UIKit

class ReviewPageMenuVC: BaseVC {
    var pageMenu : CAPSPageMenu?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ratings & Review"
        self.setupBackBarButton()
        self.setupNotificationNavBarButton()
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let controller1 : UIViewController = ReviewVC.init(nibName: "ReviewVC", bundle: nil)
        controller1.title = "Review"
        controllerArray.append(controller1)
        
        let controller2 : UIViewController = ReviewedVC.init(nibName: "ReviewedVC", bundle: nil)
        controller2.title = "Reviewed"
        controllerArray.append(controller2)
        
        
        let parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(.white),
//            .viewBackgroundColor(.yellow),
            .selectionIndicatorColor(Colors.colorWithHexString(Colors.APP_COLOR)),
//            .addBottomMenuHairline(false),
            .menuItemFont(UIFont.init(name: "SFUIText-Regular", size: 17.0)!),
            .menuHeight(35),
            .selectionIndicatorHeight(2.0),
            .menuItemWidthBasedOnTitleTextWidth(true),
            .selectedMenuItemLabelColor(Colors.colorWithHexString(Colors.APP_COLOR)),
            .menuItemSeparatorWidth(40.3),
//            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .menuItemSeparatorColor(.red)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 80, width: self.view.frame.width, height: self.view.frame.height-100), pageMenuOptions: parameters)
        print(self.view.frame.height)
        self.view.addSubview(pageMenu!.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
