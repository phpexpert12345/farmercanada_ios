//
//  MessagePageMenu.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 16/01/21.
//

import UIKit

class MessagePageMenu: BaseVC {
    
    var pageMenu1 : CAPSPageMenu?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Inbox"
        self.setupBackBarButton()
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let controller1 : UIViewController = MessageVC.init(nibName: "MessageVC", bundle: nil)
        controller1.title = "Message"
        controllerArray.append(controller1)
        
        let controller2 : UIViewController = NotificationVC.init(nibName: "NotificationVC", bundle: nil)
        controller2.title = "Notification"
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
            .menuItemSeparatorWidth(4.3),
//            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .menuItemSeparatorColor(.clear)
        ]
        
        // Initialize scroll menu
        pageMenu1 = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 80, width: self.view.frame.width, height: self.view.frame.height-100), pageMenuOptions: parameters)
        print(self.view.frame.height)
        self.view.addSubview(pageMenu1!.view)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
