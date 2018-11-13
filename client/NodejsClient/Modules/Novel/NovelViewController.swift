//
//  NovelViewController.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/10.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit
import DynamicColor

class NovelViewController: UIViewController {

    // 推荐小说列表
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var hTableView: UITableView!
    
    enum Const {
        static let closeCellHeight: CGFloat = 144
        static let openCellHeight: CGFloat = 399
    }
    var cellHeights: [CGFloat] = []
    
    var recommendNovels: [RecommendNovel] = []
    
    lazy var searchController: UISearchController = {
        let _searchController = UISearchController.init(searchResultsController: nil)
        _searchController.delegate = self
        _searchController.searchBar.tintColor = UIColor(hexString: "#23A623")
        _searchController.searchBar.delegate = self
        _searchController.dimsBackgroundDuringPresentation = false
        _searchController.searchBar.placeholder = "搜索小说"
        _searchController.hidesBottomBarWhenPushed = true

        return _searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mTableView.tableHeaderView = searchController.searchBar
        
        self.configTableView()
        self.getRecommendNovels()
    }
        
    func configTableView() {
        mTableView.estimatedRowHeight = Const.closeCellHeight
        mTableView.rowHeight = UITableView.automaticDimension
        
        let refreshControl = UIRefreshControl.init()
        refreshControl.attributedTitle = NSAttributedString.init(string: "下拉刷新")
        refreshControl.addTarget(self, action: #selector(getRecommendNovels), for: .valueChanged)
        self.mTableView.refreshControl = refreshControl
    }

    // MARK: ===== Data Request =====
    @objc func getRecommendNovels() {
        NetworkClient.getCommendNovels(success: { (novels) in
            self.recommendNovels = novels
            self.cellHeights = Array(repeating: Const.closeCellHeight, count: self.recommendNovels.count)
            self.mTableView.reloadData()
            self.mTableView.refreshControl?.endRefreshing()
            self.mTableView.refreshControl?.attributedTitle = NSAttributedString.init(string: "下拉刷新")
        }) { (error) in
            self.mTableView.refreshControl?.endRefreshing()
            self.mTableView.refreshControl?.attributedTitle = NSAttributedString.init(string: "下拉刷新")
        }
    }
}

extension NovelViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange")
        hTableView.reloadData()
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        hTableView.isHidden = false
        mTableView.isHidden = true
        hTableView.reloadData()
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        hTableView.isHidden = true
        mTableView.isHidden = false
        mTableView.reloadData()
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
}

extension NovelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mTableView {
            return recommendNovels.count
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == mTableView {
            return cellHeights[indexPath.row]
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == mTableView {
            return 0.01
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == mTableView {
            return ""
        }
        return searchController.searchBar.text != "" ? "搜索结果" : "搜索历史"
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == mTableView {
            guard case let cell as NovelCell  = cell else {
                return
            }
            
            cell.backgroundColor = .clear
            
            if cellHeights[indexPath.row] == Const.closeCellHeight {
                cell.unfold(false, animated: false, completion: nil)
            } else {
                cell.unfold(true, animated: false, completion: nil)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == mTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NovelCell", for: indexPath) as! NovelCell
            let model = recommendNovels[indexPath.row]
            cell.novelModel = model
            cell.startReadingAction = { () in
                let webController = NovelWebController()
                webController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(webController, animated: true)
            }
            
            let durations: [TimeInterval] = [0.26, 0.2, 0.2]
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHisoryCell", for: indexPath) as! SearchHistoryCell
        cell.searchTitle.text = "搜索历史\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == mTableView {
            let cell = tableView.cellForRow(at: indexPath) as! NovelCell
            
            if cell.isAnimating() { return }
            
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
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
