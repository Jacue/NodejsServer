//
//  MenuViewController.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/7.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var menuBgView: UIImageView!
    @IBOutlet weak var menuBgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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


extension MenuViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0) {
            menuBgViewHeight.constant = 150 + abs(scrollView.contentOffset.y)
//            menuBgView.alpha = 0.6 + abs(scrollView.contentOffset.y) / 200.0 * 0.7
            blurView.alpha = 1 - abs(scrollView.contentOffset.y) / 200.0
        }
    }
}
