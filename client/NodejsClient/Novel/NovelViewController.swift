//
//  NovelViewController.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/10.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit

class NovelViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    
    lazy var searchController: UISearchController = {
        let nav = UINavigationController.init(rootViewController: NovelSearchResultController())
        let _searchController = UISearchController.init(searchResultsController: nav)
        _searchController.searchResultsUpdater = self
        _searchController.searchBar.delegate = self
        _searchController.searchBar.placeholder = "搜索小说"
        
        return _searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mTableView.tableHeaderView = searchController.searchBar
        
        self.mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
