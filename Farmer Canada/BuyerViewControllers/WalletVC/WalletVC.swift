//
//  WalletVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 18/01/21.
//

import UIKit

class WalletVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var viewTopBg: UIImageView!
    @IBOutlet weak var viewWalletBg: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnSave)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            let statusBar1 =  UIView()
            statusBar1.frame = (UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame)!
            statusBar1.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
            UIApplication.shared.keyWindow?.addSubview(statusBar1)
        } else {
            let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar1.backgroundColor = Colors.colorWithHexString(Colors.APP_COLOR)
        }
        self.setupNavBarColor(.white, Colors.colorWithHexString(Colors.APP_COLOR))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if #available(iOS 13.0, *) {
            let statusBar1 =  UIView()
            statusBar1.frame = (UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame)!
            statusBar1.backgroundColor = UIColor.white
            UIApplication.shared.keyWindow?.addSubview(statusBar1)
        } else {
            let statusBar1: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
            statusBar1.backgroundColor = UIColor.white
        }
        self.setupNavBarColor(.black, .white)
    }
    
    func setupNavBarColor(_ textColor : UIColor, _ navBarColor : UIColor) -> Void {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = navBarColor
            appearance.titleTextAttributes = [.foregroundColor: textColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: textColor, .font: UIFont.init(name: "SFUIText-Regular", size: 17.0)!]
            appearance.shadowColor = .clear
            self.navigationController?.navigationBar.tintColor = textColor
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.compactAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationController?.navigationBar.tintColor = navBarColor
            self.navigationController?.navigationBar.barTintColor = navBarColor
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: textColor, .font: UIFont.init(name: "SFUIText-Regular", size: 17.0)!]
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: textColor]
        }
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Wallet"
        self.setupBackBarButton()
        self.setupNotificationNavBarButton()
        self.setupNavBarColor(.white, Colors.colorWithHexString(Colors.APP_COLOR))
        UtilityMethods.changeImageColor(self.viewTopBg, Colors.colorWithHexString(Colors.APP_COLOR))
        self.viewWalletBg.layer.cornerRadius = 5.0
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.screenWidth, height: 30))
        let lblTitle = UILabel.init(frame: CGRect.init(x: 15, y: 10, width: self.screenWidth-30, height: 20))
        lblTitle.font = UIFont.init(name: "SFUIText-Regular", size: 13.0)!
        if section == 0 {
            lblTitle.text = "Today"
        }else {
            lblTitle.text = "Yesterday"
        }
        lblTitle.textColor = .darkGray
        headerView.addSubview(lblTitle)
        return headerView
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("WalletTVC", owner: self, options: nil)?.first as! WalletTVC
        cell.selectionStyle = .none
        
        if (indexPath.section == 0) && (indexPath.row == 2) {
            cell.viewWalletBg.backgroundColor = Colors.colorWithHexString(Colors.LIGHT_GREEN)
            cell.imageViewWallet.image = UIImage.init(named: "wallet_green")
        }else if (indexPath.section == 1) && (indexPath.row == 0) {
            cell.viewWalletBg.backgroundColor = Colors.colorWithHexString(Colors.LIGHT_GREEN)
            cell.imageViewWallet.image = UIImage.init(named: "wallet_green")
        }else {
            cell.viewWalletBg.backgroundColor = Colors.colorWithHexString(Colors.LIGHT_RED)
            cell.imageViewWallet.image = UIImage.init(named: "wallet_red")
        }
        
        cell.viewWalletBg.layer.cornerRadius = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            cell.viewBg.frame = CGRect.init(x: 15, y: 7.5, width: UIScreen.main.bounds.width-30, height: cell.viewBg.bounds.height)
            UtilityMethods.addShadow(cell.viewBg)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
//    MARK:- Button Action
    @IBAction func btnWalletTapped(_ sender: UIButton) {
    }
}
