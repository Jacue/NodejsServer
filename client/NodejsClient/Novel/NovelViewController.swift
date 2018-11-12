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

    @IBOutlet weak var mTableView: UITableView!
    
    enum Const {
        static let closeCellHeight: CGFloat = 144
        static let openCellHeight: CGFloat = 399
    }
    var cellHeights: [CGFloat] = []
    
    var recommendNovels: [RecommendNovel] = []
    
    lazy var searchController: UISearchController = {
        let nav = UINavigationController.init(rootViewController: NovelSearchResultController())
        let _searchController = UISearchController.init(searchResultsController: nav)
        _searchController.searchResultsUpdater = self
        _searchController.searchBar.tintColor = UIColor(hexString: "#23A623")
        _searchController.searchBar.delegate = self
        _searchController.searchBar.placeholder = "搜索小说"
        
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
        self.mTableView.backgroundColor = UIColor(patternImage: UIImage.init(named: "background")!)
        
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

extension NovelViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange")
    }
}

extension NovelViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendNovels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NovelCell", for: indexPath) as! NovelCell
        let model = recommendNovels[indexPath.row]
        cell.novelModel = model
        
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! NovelCell
        
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
}
