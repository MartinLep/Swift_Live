//
//  NetWorkTools.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/30.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case GET
    case POST
}

class NetWorkTools{
    class func  requestData(type: MethodType,URLString: String, parameters : [String : NSString]? = nil,finishedCallback : @escaping (_ result : Any) -> ()) {
        //获取类型
        
        let method = type == .GET ? HTTPMethod.get:HTTPMethod.post
        Alamofire.request(URLString ,method: method ,parameters: parameters).responseJSON{
            (response) in
            guard let result = response.result.value else{
                print(response.result.error ?? "error")
                return
            }
            finishedCallback(result)
        }
    }
}
