//
//  ReviewVC.swift
//  Farmer Canada
//
//  Created by Arun Kumar Rathore on 16/01/21.
//

import UIKit

class ReviewVC: BaseVC, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupViewDidLoadMethod()
    }
    
    func setupViewDidLoadMethod() -> Void {
        self.setupBackBarButton()
        self.setupNotificationNavBarButton()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ReviewTVC", owner: self, options: nil)?.first as! ReviewTVC
        cell.selectionStyle = .none
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            cell.viewContainer.frame = CGRect.init(x: 15, y: 7.5, width: UIScreen.main.bounds.width-30, height: cell.viewContainer.bounds.height)
            UtilityMethods.addShadow(cell.viewContainer)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
