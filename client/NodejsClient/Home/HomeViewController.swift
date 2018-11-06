//
//  HomeViewController.swift
//  NodejsClient
//
//  Created by Jacue on 2018/9/25.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit
import FoldingCell
import SnapKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var users: [User] = []
    @IBOutlet weak var tableView: UITableView!
    
    enum Const {
        static let closeCellHeight: CGFloat = 179
        static let openCellHeight: CGFloat = 488
    }
    
    var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupActionItems()
        self.configTableView()
        self.getRecords()
    }
    
    // MARK: ===== Data Request =====
    @objc func getRecords() {
        if let _ = self.tableView.refreshControl?.isRefreshing {
            self.tableView.refreshControl?.attributedTitle = NSAttributedString.init(string: "加载中...")
        }
        NetworkClient.getRecords(success: { (userInfo) in
            self.users = userInfo
            self.cellHeights = Array(repeating: Const.closeCellHeight, count: self.users.count)
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.refreshControl?.attributedTitle = NSAttributedString.init(string: "下拉刷新")
        }) { (error) in
            self.tableView.refreshControl?.endRefreshing()
            self.tableView.refreshControl?.attributedTitle = NSAttributedString.init(string: "下拉刷新")
        }
    }
    
    
    /// 删除数据
    ///
    /// - Parameter uid: 记录的唯一标识id
    func deleteRecord(by uid: Int32) {
        NetworkClient.deleteRecord(params: ["uid": uid], success: { (response) in
            
        }, failure: { (error) in
            
        })
    }
    
    // MARK: ===== UI Config =====
    func setupActionItems() {
        let addItem = UIButton.init(type: .custom)
        addItem.setImage(UIImage.init(named: "add"), for: .normal)
        addItem.backgroundColor = UIColor.white
        addItem.layer.cornerRadius = 20
        addItem.layer.masksToBounds = true
        addItem.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        self.view.addSubview(addItem)
        self.view.bringSubviewToFront(addItem)
        
        addItem.snp.makeConstraints { (make) in
            make.width.height.equalTo(40)
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-20)
        }
    }
    
    func configTableView() {
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        self.tableView.backgroundColor = UIColor(patternImage: UIImage.init(named: "background")!)

        let refreshControl = UIRefreshControl.init()
        refreshControl.attributedTitle = NSAttributedString.init(string: "下拉刷新")
        refreshControl.addTarget(self, action: #selector(getRecords), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    // MARK: ===== Action =====
    
    @objc func addAction() {
        let alertController = UIAlertController.init(title: "提示", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入姓名"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入学校名称"
        }
        alertController.addAction(UIAlertAction.init(title: "确定", style: .default, handler: { (action) in
            guard let userName = alertController.textFields?.first?.text, userName.count > 0 else {
                return
            }
            guard let schoolName = alertController.textFields?.last?.text, schoolName.count > 0 else {
                return
            }
            let params = ["userName": userName, "schoolName": schoolName]
            NetworkClient.addRecord(params: params, success: { (response) in
                if let code = response["code"] as? Int32, code == 200 {
                    self.getRecords()
                }
            }, failure: { (error) in
                
            })
        }))
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as HomeCell  = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! HomeCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let userInfo = users[indexPath.row]
            if let uid = userInfo.uid {
                users.remove(at: indexPath.row)
                self.deleteRecord(by: uid)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
