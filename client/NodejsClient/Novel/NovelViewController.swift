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
    
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let nav = UINavigationController.init(rootViewController: NovelSearchResultController())
        searchController = UISearchController.init(searchResultsController: nav)
        searchController!.searchResultsUpdater = self
        searchController!.searchBar.delegate = self
        searchController!.searchBar.placeholder = "搜索小说"
        if #available(iOS 9.1, *) {
            searchController?.obscuresBackgroundDuringPresentation = false
        }
        searchController?.dimsBackgroundDuringPresentation = false

        self.mTableView.tableHeaderView = searchController!.searchBar
        
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
