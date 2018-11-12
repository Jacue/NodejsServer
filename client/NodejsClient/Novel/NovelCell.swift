//
//  NovelCell.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/12.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit
import FoldingCell
import DynamicColor
import Kingfisher

class NovelCell: FoldingCell {

    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var wordsNumLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    
    var novelModel: RecommendNovel? {
        didSet {
            coverImageView.kf.setImage(with: URL(string: (novelModel?.book_cover)!))
            bookNameLabel.text = novelModel?.bookname
            authorLabel.text = novelModel?.author_name
            if let size = novelModel?.size {
                wordsNumLabel.text = size.transform(by: .tenThousand) + "字"
            }
            if let timeStamp = novelModel?.date_updated {
                updateDateLabel.text = "最近更新: " + timeStamp.getDateFromTimeStamp()
            }
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 4
        foregroundView.layer.masksToBounds = true
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.cornerRadius = 4
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [UIColor(hexString: "#333333").cgColor, UIColor(hexString: "#999999").cgColor]
        gradientView.layer.addSublayer(gradientLayer)
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
