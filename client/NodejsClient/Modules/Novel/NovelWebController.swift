//
//  NovelWebController.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/13.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit
import WebKit

class NovelWebController: UIViewController {
    
    var bid: String = ""
    var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupSubViews()
    }
    
    func setupSubViews() {
        self.view.backgroundColor = UIColor.white
        
        let webConfiguration = WKWebViewConfiguration()
        let myURL = URL(string: "http://t.shuqi.com/route.php?pagename=#!/bid/" + bid + "/ct/read")
        webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        let myRequest = URLRequest(url: myURL!)
        webView?.load(myRequest)
        view.addSubview(webView!)

    }

}

extension NovelWebController: WKUIDelegate, WKNavigationDelegate {
    //页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    //当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    //页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
}
