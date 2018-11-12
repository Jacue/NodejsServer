//
//  NetworkClient.swift
//  NodejsClient
//
//  Created by Jacue on 2018/9/25.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit
import Alamofire

class NetworkClient: NSObject {
    
    class func getRecords(success:@escaping(_ response:[User])->(),failure:@escaping(_ error:Error)->()) {
        ApiBaseClient.shareInstance.getRequest(urlString: URLs.records, success: { (responseObj) in
            if let arr = responseObj["data"] as? [[String: AnyObject]] {
                guard let data = try? JSONSerialization.data(withJSONObject: arr) else {
                    return
                }
                guard let users = try? JSONDecoder().decode([User].self, from: data) else {
                    return
                }
                success(users)
            }
        }) { (error) in
            failure(error)
        }
    }
    
    class func addRecord(params:[String: String] ,success:@escaping(_ response:[String: AnyObject])->(),failure:@escaping(_ error:Error)->()) {
        ApiBaseClient.shareInstance.postRequest(urlString: URLs.addRecord, params: params, success: success, failure: failure)
    }
    
    class func deleteRecord(params:[String: Int32] ,success:@escaping(_ response:[String: AnyObject])->(),failure:@escaping(_ error:Error)->()) {
        ApiBaseClient.shareInstance.deleteRequest(urlString: URLs.deleteRecord, params: params, success: success, failure: failure)
    }
}


extension NetworkClient {
    class func getCommendNovels(success:@escaping(_ response: [RecommendNovel])->(),failure:@escaping(_ error:Error)->()) {
        ApiBaseClient.shareInstance.getRequest(urlString: URLs.recommendNovel, success: { (responseObj) in
            if let arr = responseObj["data"] as? [[String: AnyObject]] {
                guard let data = try? JSONSerialization.data(withJSONObject: arr) else {
                    return
                }
                guard let recommendNovels = try? JSONDecoder().decode([RecommendNovel].self, from: data) else {
                    return
                }
                success(recommendNovels)
            }
        }) { (error) in
            failure(error)
        }
    }
}
