//
//  RecomendViewModel.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/30.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class RecomendViewModel{

    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension RecomendViewModel{
    func requestData(){
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":"4","offset":"0","time":NSDate.getcurrentTime() as NSString]) { (result) in
            
            //将result转成字典
            guard let resultDict = result as? [String : NSObject] else {return}
            //获取data数组
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //遍历数组获取字典，并且将字典转成模型对象
            
            for dict in dataArray{
                let group = AnchorGroup(dict:dict)
                self.anchorGroups.append(group)
            }
            
            for group in self.anchorGroups{
                for anchor in group.anchors{
                    print(anchor.nickname)
                }
            }
        }
    }
}
