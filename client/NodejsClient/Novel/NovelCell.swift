//
//  NovelCell.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/12.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit
import FoldingCell

class NovelCell: FoldingCell {

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 4
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
