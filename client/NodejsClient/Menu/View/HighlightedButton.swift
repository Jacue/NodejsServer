//
//  HighlightedButton.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/9.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit

class HighlightedButton: UIButton {

    override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            if (newValue) {
                self.backgroundColor = UIColor.lightGray
            } else {
                self.backgroundColor = UIColor.white
            }
        }
        get {
            return super.isHighlighted
        }
    }
}
