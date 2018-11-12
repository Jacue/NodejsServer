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
import SlideMenuControllerSwift

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupActionItems()
    }
    
    // MARK: ===== Data Request =====
    
    
    /// 删除数据
    ///
    /// - Parameter uid: 记录的唯一标识id
    
    // MARK: ===== UI Config =====
    func setupActionItems() {

        self.addLeftBarButtonWithImage(UIImage(named: "user")!)
        
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
            make.bottom.equalTo(self.view).offset(-69)
        }
    }
    
    
    // MARK: ===== Action =====
    
    @objc func addAction() {

    }

    // MARK: - Table view data source

}


extension HomeViewController: SlideMenuControllerDelegate {
    func leftDidOpen() {
        print("leftDidOpen")

        if let leftPanGes = self.slideMenuController()?.leftPanGesture {
            self.slideMenuController()?.view.removeGestureRecognizer(leftPanGes)
            self.slideMenuController()?.leftPanGesture = nil
        }
    }
    
    func leftDidClose() {
        print("leftDidClose")
        self.slideMenuController()?.addLeftGestures()
    }
}
