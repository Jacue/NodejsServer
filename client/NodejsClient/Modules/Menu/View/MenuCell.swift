//
//  MenuCell.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/9.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
