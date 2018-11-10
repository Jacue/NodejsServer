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
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var headPortrait: UIImageView!
    
    @IBOutlet weak var mTableView: UITableView!
    let cellIcons = [["favorites", "comment", "thumbs", "history"],["feedback", "setting"]]
    let cellTitles = [["我的收藏", "我的评论", "我的点赞", "浏览历史"],["用户反馈", "系统设置"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupSubViews()
    }
    
    func setupSubViews() {

    }
        
    @IBAction func editHeadPortrait(_ sender: UIButton) {
        
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction.init(title: "拍照", style: .default) { (action) in
            let imagePicker = UIImagePickerController.init()
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                imagePicker.delegate = self;
                imagePicker.sourceType = .camera;
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let action2 = UIAlertAction.init(title: "从手机相册选择", style: .default) { (action) in
            let imagePicker = UIImagePickerController.init()
            if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
                imagePicker.delegate = self;
                imagePicker.sourceType = .photoLibrary;
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        let action3 = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
    }
        
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        default:
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.icon.image = UIImage.init(named: cellIcons[indexPath.section][indexPath.row])
        cell.titleLabel.text = cellTitles[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < 0) {
            menuBgViewHeight.constant = 150 + abs(scrollView.contentOffset.y)
            blurView.alpha = 1 - abs(scrollView.contentOffset.y) / 200.0
        }
    }
}


extension MenuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            headPortrait.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
