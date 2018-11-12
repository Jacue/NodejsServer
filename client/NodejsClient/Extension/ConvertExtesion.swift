//
//  StringExtesion.swift
//  NodejsClient
//
//  Created by Jacue on 2018/11/12.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit

enum NumberLevel {
    case hundred
    case thousand
    case tenThousand
}

extension String {

    
    /// 数量根据单位转换
    ///
    /// - Parameter by: 单位（百、千、万）
    /// - Returns: 如 “100万”
    func transform(by level: NumberLevel) -> String {
        
        var convertedString = ""
        
        if let number = Int64(self) {
            switch level {
            case .hundred:
                let convertedNumber = Int64(number / 100)
                convertedString = "\(convertedNumber)" + "百"
            case .thousand:
                let convertedNumber = Int64(number / 1000)
                convertedString = "\(convertedNumber)" + "千"
            case .tenThousand:
                let convertedNumber = Int64(number / 10000)
                convertedString = "\(convertedNumber)" + "万"
            }
        }
        return convertedString
    }
}

extension Int64 {
    
    /// 将时间戳转化为日期字符串
    ///
    /// - Parameter format: 日期格式
    /// - Returns: 日期字符串
    func getDateFromTimeStamp(by format: String? = "YYYY-MM-dd") -> String {
        var convertedString = ""
        if let timeStamp = Double(self) as Double? {
            let date = Date.init(timeInterval: timeStamp, since: Date.init(timeIntervalSince1970: 0))
            
            let formatter = DateFormatter()
            formatter.dateFormat = format
            convertedString = formatter.string(from: date)
        }
        return convertedString
    }
}
