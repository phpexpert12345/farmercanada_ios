//
//  OrderPreviewVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 11/01/21.
//

import UIKit

class OrderPreviewVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblChange: UILabel!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var lblAddressTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var viewAddressContainer: UIView!
    @IBOutlet weak var viewPaymentContainer: UIView!
    @IBOutlet weak var imageViewSelectCash: UIImageView!
    @IBOutlet weak var imageViewSelectCard: UIImageView!
    @IBOutlet weak var imageViewSelectWallet: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewProductContainer: UIView!
    @IBOutlet weak var productViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var appliedCouponHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var viewRemoveCoupon: UIView!
    @IBOutlet weak var btnCheckOut: UIButton!
    
    var arrayCartList = ["cart1", "cart2", "cart3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.setupBackBarButton()
        self.navigationItem.title = "Order Preview"
        self.setupNotificationNavBarButton()
        
        self.lblChange.textColor = Colors.colorWithHexString(Colors.BUTTON_COLOR)
        self.viewLocation.layer.cornerRadius = 5.0
        UtilityMethods.addBorder(self.viewAddressContainer, Colors.colorWithHexString(Colors.BUTTON_COLOR), 5.0)
        UtilityMethods.addShadow(self.viewPaymentContainer)
        self.viewAddressContainer.backgroundColor = .white
        self.setupTableViewDelegateAndDatasource()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.setNeedsLayout()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableViewHeight.constant = self.tableView.contentSize.height
        self.productViewHeight.constant = self.tableView.contentSize.height + 65.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UtilityMethods.addShadow(self.viewProductContainer)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnCheckOut)
        self.addDashedBorder(self.viewContainer)
    }
    
    func setupTableViewDelegateAndDatasource() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 50
    }
    
//    MARK:- UITableView Delegate And Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayCartList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CartProductTVC", owner: self, options: nil)?.first as! CartProductTVC
        cell.selectionStyle = .none
        cell.indexPath = indexPath
        cell.imageViewProduct.image = UIImage.init(named: self.arrayCartList[indexPath.row])
        cell.lblProductName.text = "Quince eco."
        cell.lblProductDes.text = "Northwest Territories, Canada"
        cell.imageViewProduct.layer.cornerRadius = cell.imageViewProduct.bounds.height/2
        cell.imageViewProduct.layer.masksToBounds = true
        return cell
    }
    
//    MARK:- Button Action
    @IBAction func btnChangeAddressTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCashOnDeliveryTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnCreditDebitCardTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnWalletTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnRemoveCouponTapped(_ sender: UIButton) {
        self.lblTotalAmount.text = "$301.00"
        self.appliedCouponHeight.constant = 0.5
        self.viewRemoveCoupon.isHidden = true
        self.shapeLayer.removeFromSuperlayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewContainer.frame = CGRect.init(x: self.viewContainer.frame.origin.x, y: self.viewContainer.frame.origin.y, width: self.viewContainer.bounds.width, height: self.viewContainer.bounds.height)
            self.addDashedBorder(self.viewContainer)
        }
    }
    
    @IBAction func btnCheckOutTapped(_ sender: UIButton) {
        let thankyouVC = ThankYouVC.init(nibName: "ThankYouVC", bundle: nil)
        self.tabBarController?.navigationController?.pushViewController(thankyouVC, animated: true)
    }
    
    //    DashLayer
    let shapeLayer:CAShapeLayer = CAShapeLayer()
    func addDashedBorder(_ view : UIView) {
        let color = UIColor.lightGray.cgColor
        let frameSize = view.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        view.layer.addSublayer(shapeLayer)
      }
}
