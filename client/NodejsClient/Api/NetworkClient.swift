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
    
    func getRecords(success:@escaping(_ response:[String:AnyObject])->(),failure:@escaping(_ error:Error)->()) {
        ApiBaseClient.shareInstance.getRequest(urlString: URLs.records, success: success, failure: failure)
    }
}
