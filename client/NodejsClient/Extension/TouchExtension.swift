//
//  TouchExtension.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/9.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit


// MARK: - ScrollView会截获UITouch事件，此处将Touch事件回传给下一个响应者
extension UIScrollView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesMoved(touches, with: event)
    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesEnded(touches, with: event)
    }
}
