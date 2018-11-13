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
import Toast_Swift

class NovelCell: FoldingCell {

    // foreground
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var wordsNumLabel: UILabel!
    @IBOutlet weak var updateDateLabel: UILabel!
    
    // container => first
    @IBOutlet weak var gradientView2: UIView!
    @IBOutlet weak var coverImageView2: UIImageView!
    @IBOutlet weak var bookNameLabel2: UILabel!
    @IBOutlet weak var authorLabel2: UILabel!
    @IBOutlet weak var wordsNumLabel2: UILabel!
    @IBOutlet weak var updateDateLabel2: UILabel!

    // second
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    
    // third
    @IBOutlet weak var thirdContainerView: RotatedView!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var tagLabel1: UILabel!
    @IBOutlet weak var tagLabel2: UILabel!
    @IBOutlet weak var tagLabel3: UILabel!
    @IBOutlet weak var tagLabel4: UILabel!
    
    var updatedTopicAction: (()->Void)?
    var startReadingAction: (()->Void)?
    
    lazy var gradientLayer: CAGradientLayer = {
        let _gradientLayer = CAGradientLayer()
        _gradientLayer.cornerRadius = 4
        _gradientLayer.frame = gradientView.bounds
        _gradientLayer.colors = [UIColor(hexString: "#333333").cgColor, UIColor(hexString: "#999999").cgColor]
        return _gradientLayer
    }()
    
    lazy var gradientLayer2: CAGradientLayer = {
        let _gradientLayer2 = CAGradientLayer()
        _gradientLayer2.cornerRadius = 4
        _gradientLayer2.frame = gradientView.bounds
        _gradientLayer2.colors = [UIColor(hexString: "#333333").cgColor, UIColor(hexString: "#999999").cgColor]
        return _gradientLayer2
    }()

    var novelModel: RecommendNovel? {
        didSet {
            // 未展开
            coverImageView.kf.setImage(with: URL(string: (novelModel?.book_cover)!))
            bookNameLabel.text = novelModel?.bookname
            authorLabel.text = novelModel?.author_name
            if let size = novelModel?.size {
                wordsNumLabel.text = size.transform(by: .tenThousand) + "字"
            }
            if let timeStamp = novelModel?.date_updated {
                updateDateLabel.text = "最近更新: " + timeStamp.getDateFromTimeStamp()
            }
            
            // 展开
            coverImageView2.kf.setImage(with: URL(string: (novelModel?.book_cover)!))
            bookNameLabel2.text = novelModel?.bookname
            authorLabel2.text = novelModel?.author_name
            if let size = novelModel?.size {
                wordsNumLabel2.text = size.transform(by: .tenThousand) + "字"
            }
            if let timeStamp = novelModel?.date_updated {
                updateDateLabel2.text = "最近更新: " + timeStamp.getDateFromTimeStamp()
            }

            introductionLabel.text = novelModel?.introduction?.replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "")
            topicLabel.text = novelModel?.topic
            
            if let className = novelModel?.class_name {
                classLabel.text = " " + className + " " // 左右留空间
            }

            if let tags = novelModel?.tag {
                for (index, tagName) in tags.enumerated() {
                    if let label = thirdContainerView.viewWithTag(index + 10) as? UILabel {
                        label.text = " " + tagName + " " // 左右留空间
                        label.isHidden = false
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 4
        foregroundView.layer.masksToBounds = true
        
        gradientView.layer.addSublayer(gradientLayer)
        gradientView2.layer.addSublayer(gradientLayer2)
        
        classLabel.layer.borderColor = UIColor(hexString: "DD527A").cgColor
        tagLabel1.layer.borderColor = UIColor(hexString: "23A623").cgColor
        tagLabel2.layer.borderColor = UIColor(hexString: "1C2DA6").cgColor
        tagLabel3.layer.borderColor = UIColor(hexString: "DD9429").cgColor
        tagLabel4.layer.borderColor = UIColor.red.cgColor
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func clickUpdatedTopic(_ sender: UIButton) {
        if let window = UIApplication.shared.delegate?.window {
            window!.makeToast("阅读最新章节", duration: 3.0, position: .center)
            if updatedTopicAction != nil {
                updatedTopicAction!()
            }
        }
    }
    
    @IBAction func startReading(_ sender: UIButton) {
        if let window = UIApplication.shared.delegate?.window {
            window!.makeToast("开始阅读", duration: 3.0, position: .center)
            if startReadingAction != nil {
                startReadingAction!()
            }
        }
    }
    
}
