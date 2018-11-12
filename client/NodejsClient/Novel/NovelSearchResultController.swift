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
        _mTableView.backgroundColor = UIColor.red
        return _mTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(mTableView)
        mTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(64)
            make.left.right.bottom.equalTo(view)
        }
        
        self.getRecommendNovels()
    }
    
    // MARK: ===== Data Request =====
    @objc func getRecommendNovels() {
        NetworkClient.getCommendNovels(success: { (novelInfo) in
            
        }) { (error) in
            
        }
    }


    
}
