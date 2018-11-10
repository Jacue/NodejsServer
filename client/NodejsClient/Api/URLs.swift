//
//  URLs.swift
//  NodejsClient
//
//  Created by Jacue on 2018/9/25.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit

class URLs: NSObject {
    static let baseUrl = "http://99.48.98.129:3001/users/"
    static let records = "allRecords"
    static let addRecord = "addRecord"
    static let deleteRecord = "deleteRecord"
}

extension URLs {
    static let novelBaseUrl = "https://www.apiopen.top/"
    
    /// 推荐小说
    static let recommendNovel = "novelApi"
    
    /// 搜索小说
    static let search = "novelSearchApi"
    
    /// 小说详情
    static let novelInfo = "novelInfoApi"
}
