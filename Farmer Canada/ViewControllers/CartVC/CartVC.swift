//
//  CartVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 08/01/21.
//

import UIKit

class CartVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnAddItem: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblItemCount: UILabel!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewCoupon: UIView!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var textFieldApplyCoupon: UITextField!
    @IBOutlet weak var viewAppliedCoupon: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var appliedCouponHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var heightApplyCoupon: NSLayoutConstraint!
    @IBOutlet weak var viewRemoveCoupon: UIView!
    @IBOutlet weak var btnCheckOut: UIButton!
    
    var arrayCartList = ["cart1", "cart2", "cart3", "cart1", "cart2", "cart3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableViewHeight.constant = self.tableView.contentSize.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnApply)
        self.createGradientColorWith(Colors.colorWithHexString(Colors.LIGHT_COLOR), Colors.colorWithHexString(Colors.DARK_COLOR), self.btnCheckOut)
        self.viewContainer.frame = CGRect.init(x: self.viewContainer.frame.origin.x, y: self.viewContainer.frame.origin.y, width: self.viewContainer.bounds.width, height: self.viewContainer.bounds.height)
        self.addDashedBorder(self.viewContainer)
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.tabBarController?.navigationItem.title = "Cart"
        self.lblItemCount.text = "4 Items"
        self.setupNotificationTabBarButton()
        self.setupTableViewDelegateAndDatasource()
        self.viewCoupon.layer.cornerRadius = 5.0
        self.viewAppliedCoupon.layer.cornerRadius = 5.0
        self.btnApply.layer.cornerRadius = 5.0
        self.btnCheckOut.layer.cornerRadius = 5.0
        self.btnAddItem.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
        self.btnApply.setTitleColor(.white, for: .normal)
        self.viewCoupon.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
        self.viewAppliedCoupon.backgroundColor = Colors.colorWithHexString(Colors.WHITE_SMOKE)
        self.appliedCouponHeight.constant = 0.5
        self.viewRemoveCoupon.isHidden = true
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
        let cell = Bundle.main.loadNibNamed("CartItemTVC", owner: self, options: nil)?.first as! CartItemTVC
        cell.selectionStyle = .none
        cell.indexPath = indexPath
        cell.imageViewProduct.image = UIImage.init(named: self.arrayCartList[indexPath.row])
        cell.lblProductName.text = "Quince eco."
        cell.lblProductDes.text = "Northwest Territories, Canada"
        cell.imageViewProduct.layer.cornerRadius = cell.imageViewProduct.bounds.height/2
        cell.imageViewProduct.layer.masksToBounds = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            cell.viewBg.frame = CGRect.init(x: 15, y: 7.5, width: UIScreen.main.bounds.width-30, height: cell.viewBg.bounds.height)
            UtilityMethods.addShadow(cell.viewBg)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let askAction = UIContextualAction(style: .normal, title: nil) { action, view, complete in
          print("Ask!")
          complete(true)
        }

        // here set your image and background color
        askAction.image = UIImage.init(named: "delete")!
        askAction.backgroundColor = .white

//        let blockAction = UIContextualAction(style: .destructive, title: "Block") { action, view, complete in
//          print("Block")
//          complete(true)
//        }

        return UISwipeActionsConfiguration(actions: [askAction])
      }

      func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.textLabel?.text = "row: \(indexPath.row)"
      }
    
//    MARK:- Button Action
    @IBAction func btnApplyCouponTapped(_ sender: UIButton) {
        self.lblTotalAmount.text = "$296.00"
        self.heightApplyCoupon.constant = 0.5
        self.viewCoupon.isHidden = true
        self.appliedCouponHeight.constant = 66.5
        self.viewRemoveCoupon.isHidden = false
        self.shapeLayer.removeFromSuperlayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewContainer.frame = CGRect.init(x: self.viewContainer.frame.origin.x, y: self.viewContainer.frame.origin.y, width: self.viewContainer.bounds.width, height: self.viewContainer.bounds.height)
            self.addDashedBorder(self.viewContainer)
        }
    }
    
    @IBAction func btnRemoveCouponTapped(_ sender: UIButton) {
        self.lblTotalAmount.text = "$301.00"
        self.heightApplyCoupon.constant = 50.0
        self.viewCoupon.isHidden = false
        self.appliedCouponHeight.constant = 0.5
        self.viewRemoveCoupon.isHidden = true
        self.shapeLayer.removeFromSuperlayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.viewContainer.frame = CGRect.init(x: self.viewContainer.frame.origin.x, y: self.viewContainer.frame.origin.y, width: self.viewContainer.bounds.width, height: self.viewContainer.bounds.height)
            self.addDashedBorder(self.viewContainer)
        }
    }
    
    @IBAction func btnCheckOutTapped(_ sender: UIButton) {
        let orderPreviewVC = OrderPreviewVC.init(nibName: "OrderPreviewVC", bundle: nil)
        self.navigationController?.pushViewController(orderPreviewVC, animated: true)
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

