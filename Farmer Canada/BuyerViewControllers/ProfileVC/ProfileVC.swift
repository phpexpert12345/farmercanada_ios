//
//  ProfileVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 08/01/21.
//

import UIKit
import CNPPopupController

class ProfileVC: BaseVC, UITableViewDelegate, UITableViewDataSource, CNPPopupControllerDelegate, NotificationPopupActionDelegate {

    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var lblEmailID: UILabel!
    @IBOutlet weak var lblBuyer: UILabel!
    @IBOutlet weak var viewLine1: UIView!
    @IBOutlet weak var viewLine2: UIView!
    @IBOutlet weak var lblFollowingCount: UILabel!
    @IBOutlet weak var lblWalletAmount: UILabel!
    @IBOutlet weak var lblMessageCount: UILabel!
    @IBOutlet weak var lblFollowersCount: UILabel!
    @IBOutlet weak var viewOrder: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewReview: UIView!
    @IBOutlet weak var viewPayment: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    
    let arraySectionTitle = ["Account Setting", "Become a Vendor", "Referrals & Credits"]
    let arrayProfileOption = [[["name" : "Edit Profile", "image" : "edit_profile"],
                               ["name" : "Change Password", "image" : "change_password"],
                               ["name" : "Notification", "image" : "profile_notification"]],
                              [["name" : "Open Store", "image" : "open_store"],
                               ["name" : "Learn About Store", "image" : "about_store"]],
                              [["name" : "Earn Money", "image" : "earn_money"],
                               ["name" : "Support", "image" : "profile_chat"],
                               ["name" : "Logout", "image" : "logout"]]]
    var popupController:CNPPopupController?
    var navigationPopupView = NavigationPopupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableViewheight.constant = self.tableView.contentSize.height
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.imageViewProfile.layer.cornerRadius = self.imageViewProfile.bounds.height/2
        self.imageViewProfile.layer.masksToBounds = true
        UtilityMethods.addBorder(self.imageViewProfile, .lightGray, self.imageViewProfile.bounds.height/2)
        self.lblBuyer.textColor = Colors.colorWithHexString(Colors.APP_COLOR)
//        self.viewLine1.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
//        self.viewLine2.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
        self.viewLine1.backgroundColor = .lightGray
        self.viewLine2.backgroundColor = .lightGray
        self.viewOrder.layer.cornerRadius = 5.0
        self.viewAddress.layer.cornerRadius = 5.0
        self.viewReview.layer.cornerRadius = 5.0
        self.viewPayment.layer.cornerRadius = 5.0
        self.setupTableViewDelegateAndDatasource()
    }
    
    func setupTableViewDelegateAndDatasource() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 30
        self.tableView.separatorStyle = .none
    }
    
//    MARK:- UITableView Delegate And Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1 {
            return 2
        }else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.screenWidth, height: 40))
        let lblTitle = UILabel.init(frame: CGRect.init(x: 15, y: 10, width: self.screenWidth-30, height: 20))
        lblTitle.font = UIFont.init(name: "SFUIText-Regular", size: 15.0)!
        lblTitle.text = self.arraySectionTitle[section]
        lblTitle.textColor = .darkGray
        headerView.addSubview(lblTitle)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ProfileTVC", owner: self, options: nil)?.first as! ProfileTVC
        cell.selectionStyle = .none
        let arrayProfile = self.arrayProfileOption[indexPath.section]
        let dictionary = arrayProfile[indexPath.row]
        cell.lblProfileTitle.text = dictionary["name"]!
        cell.imageViewProfile.image = UIImage.init(named: dictionary["image"]!)
        if (indexPath.section == 0) && (indexPath.row == 2) {
            cell.imageViewForwardArrow.isHidden = false
        }else {
            cell.imageViewForwardArrow.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) && (indexPath.row == 0) {
            let editProfileVC = EditProfileVC.init(nibName: "EditProfileVC", bundle: nil)
            self.navigationController?.pushViewController(editProfileVC, animated: true)
        }else if (indexPath.section == 0) && (indexPath.row == 1) {
            let changePasswordVC = ChangePasswordVC.init(nibName: "ChangePasswordVC", bundle: nil)
            self.navigationController?.pushViewController(changePasswordVC, animated: true)
        }else if (indexPath.section == 0) && (indexPath.row == 2) {
            self.setupNotificationPopupView()
        }else if (indexPath.section == 1) && (indexPath.row == 0) {
            
        }else if (indexPath.section == 1) && (indexPath.row == 1) {
            let aboutStore = AboutStoreVC.init(nibName: "AboutStoreVC", bundle: nil)
            self.navigationController?.pushViewController(aboutStore, animated: true)
        }else if (indexPath.section == 2) && (indexPath.row == 0) {
            let walkThroughVC = WalkThroughVC.init(nibName: "WalkThroughVC", bundle: nil)
            walkThroughVC.isMovedFromProfilePage = true
            self.navigationController?.pushViewController(walkThroughVC, animated: true)
        }else if (indexPath.section == 2) && (indexPath.row == 1) {
            let supportVC = SupportVC.init(nibName: "SupportVC", bundle: nil)
            self.navigationController?.pushViewController(supportVC, animated: true)
        }else if (indexPath.section == 2) && (indexPath.row == 2) {
            self.setupLogoutPage()
        }
    }
    
    //    Setup logout page
        func setupLogoutPage() -> Void {
            let alrtctrl = UIAlertController.init(title: ConstantStrings.ALERT, message: ConstantStrings.ARE_YOU_SURE_YOU_WANT_TO_LOGOUT, preferredStyle: .alert)
            let actionOK = UIAlertAction.init(title: ConstantStrings.OK_STRING, style: .default) { (alert) in
                
            }
            let actionCancel = UIAlertAction.init(title: ConstantStrings.CANCEL_STRING, style: .default, handler: nil)
            alrtctrl.addAction(actionCancel)
            alrtctrl.addAction(actionOK)
            self.present(alrtctrl, animated: true, completion: nil)
        }
    
    func setupNotificationPopupView() -> Void {
        self.navigationPopupView = NavigationPopupView.init(frame: CGRect.init(x: 0, y: 0, width: self.screenWidth, height: screenHeight))
        self.navigationPopupView.delegate = self
        UtilityMethods.changeButtonIconColor("down_arrow", .lightGray, self.navigationPopupView.btnRemoveView)
        
        self.navigationPopupView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 230)
        let popupController = CNPPopupController(contents:[self.navigationPopupView])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = CNPPopupStyle.actionSheet
        // LFL added settings for custom color and blur
        popupController.theme.backgroundColor = .white
        popupController.theme.maskType = .dimmed
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }
    
//    MARK:- Notification Popup Delegate
    func btnRemoveViewAction(_ sender: UIButton) {
        self.popupController?.dismiss(animated: true)
    }
    
    func switchNotifyNewChatAction(_ sender: UISwitch) {
        print("New Chat Action...")
    }
    
    func switchNotifyAddedFarmAction(_ sender: UISwitch) {
        print("Added Farm Action...")
    }
    
    func switchNotifyNewProductAction(_ sender: UISwitch) {
        print("New Product Action...")
    }
    
    func switchNotifyStockProductAction(_ sender: UISwitch) {
        print("Stock Product Action...")
    }
    
//    MARK:- Button Action
    @IBAction func btnBecomeBuyerAction(_ sender: UIButton) {
        
    }
    
    @IBAction func btnWalletAction(_ sender: UIButton) {
        let walletVC = WalletVC.init(nibName: "WalletVC", bundle: nil)
        self.navigationController?.pushViewController(walletVC, animated: true)
    }
    
    @IBAction func btnFollwingAction(_ sender: UIButton) {
        let followerVC = FollowingVC.init(nibName: "FollowingVC", bundle: nil)
        self.navigationController?.pushViewController(followerVC, animated: true)
    }
    
    @IBAction func btnFollowersAction(_ sender: UIButton) {
        let followerVC = FollowerVC.init(nibName: "FollowerVC", bundle: nil)
        self.navigationController?.pushViewController(followerVC, animated: true)
    }
    
    @IBAction func btnInboxAction(_ sender: UIButton) {
        let messagePageMenu = MessagePageMenu.init(nibName: "MessagePageMenu", bundle: nil)
        self.navigationController?.pushViewController(messagePageMenu, animated: true)
    }
    
    @IBAction func btnOrderAction(_ sender: UIButton) {
        let orderPageMenuVC = OrderPageMenu.init(nibName: "OrderPageMenu", bundle: nil)
        self.navigationController?.pushViewController(orderPageMenuVC, animated: true)
//        let orderPageMenuVC = OurPageMenuVC.init(nibName: "OurPageMenuVC", bundle: nil)
//        self.navigationController?.pushViewController(orderPageMenuVC, animated: true)
        
    }
    
    @IBAction func btnAddressAction(_ sender: UIButton) {
        let addressVC = AddressVC.init(nibName: "AddressVC", bundle: nil)
        self.navigationController?.pushViewController(addressVC, animated: true)
    }
    
    @IBAction func btnRatingAndReviewAction(_ sender: UIButton) {
        let pageMenuVC = ReviewPageMenuVC.init(nibName: "ReviewPageMenuVC", bundle: nil)
        self.navigationController?.pushViewController(pageMenuVC, animated: true)
    }
    
    @IBAction func btnPaymentAction(_ sender: UIButton) {
        let bankDetailsVC = BankDetailsVC.init(nibName: "BankDetailsVC", bundle: nil)
        self.navigationController?.pushViewController(bankDetailsVC, animated: true)
    }
    
}
