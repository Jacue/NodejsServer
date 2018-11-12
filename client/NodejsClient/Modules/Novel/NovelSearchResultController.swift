//
//  NovelSearchResultController.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/10.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit
import SnapKit

class NovelSearchResultController: UIViewController {
    
    lazy var mTableView: UITableView = {
        let _mTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        _mTableView.delegate = self
        _mTableView.dataSource = self
        _mTableView.backgroundColor = UIColor.red
        _mTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return _mTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        
        self.view.addSubview(mTableView)
        mTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.left.right.bottom.equalTo(view)
        }
        
    }
    


    
}

extension NovelSearchResultController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test string"
        return cell
    }
}
