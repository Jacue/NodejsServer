//
//  ApiBaseClient.swift
//  NodejsClient
//
//  Created by Jacue on 2018/9/25.
//  Copyright © 2018年 Jacue. All rights reserved.
//

import UIKit
import Alamofire

class ApiBaseClient: NSObject {

    static let shareInstance = ApiBaseClient()
    
    func getRequest(urlString: String,
                    params:[String:Any]? = nil,
                    success:@escaping(_ response:[String:AnyObject])->(),
                    failure:@escaping(_ error:Error)->()) {
        
        let PathUrl = URLs.baseUrl + urlString
        Alamofire.request(PathUrl, method: .get, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                if let value = response.result.value as? [String:AnyObject]{
                    success(value)
                }
                
            case .failure(let error):
                failure(error)
                print(error)
            }
            
        }
    }
    
    func postRequest(urlString: String,
                     params:[String:Any]? = nil,
                     success:@escaping(_ response:[String:AnyObject])->(),
                     failure:@escaping(_ error:Error)->()) {

        let PathUrl = URLs.baseUrl + urlString
        Alamofire.request(PathUrl, method: .post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                if let value = response.result.value as? [String:AnyObject]{
                    success(value)
                }
                
            case .failure(let error):
                failure(error)
                print(error)
            }
            
        }
    }
    
}
