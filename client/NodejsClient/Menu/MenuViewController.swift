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
    @IBOutlet weak var headPortrait: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
