//
//  AddressVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 15/01/21.
//

import UIKit

class AddressVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var btnAddAddress: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.navigationItem.title = "Address"
        self.setupBackBarButton()
        self.setupNotificationNavBarButton()
        self.setupTableViewDelegateAndDatasource()
        self.btnAddAddress.setTitleColor(Colors.colorWithHexString(Colors.BUTTON_COLOR), for: .normal)
    }
    
    func setupTableViewDelegateAndDatasource() -> Void {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 30
        self.tableView.separatorStyle = .none
    }
    
//    MARK:- UITableView Delegate And Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AddAddressTVC", owner: self, options: nil)?.first as! AddAddressTVC
        cell.selectionStyle = .none
        if indexPath.row == self.selectedIndex {
            UtilityMethods.addBorder(cell.viewContainer, Colors.colorWithHexString(Colors.APP_COLOR), 5.0)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            cell.viewContainer.frame = CGRect.init(x: 15, y: 7.5, width: UIScreen.main.bounds.width-30, height: cell.viewContainer.bounds.height)
            UtilityMethods.addShadow(cell.viewContainer)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.tableView.reloadData()
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

        let blockAction = UIContextualAction(style: .destructive, title: nil) { action, view, complete in
          print("Block")
          complete(true)
        }
        blockAction.image = UIImage.init(named: "edit_address")!
        blockAction.backgroundColor = .white

        return UISwipeActionsConfiguration(actions: [askAction, blockAction])
      }
    
//    MARK:- Button Action
    @IBAction func btnAddAddressTapped(_ sender: UIButton) {
        let addAddressVC = AddAddressVC.init(nibName: "AddAddressVC", bundle: nil)
        self.navigationController?.pushViewController(addAddressVC, animated: true)
    }
}
