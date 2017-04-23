//
//  RecomendViewModel.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/30.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class RecomendViewModel{

    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

extension RecomendViewModel{
    func requestData(finishCallBack : @escaping () -> ()){
        //定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getcurrentTime() as NSString]
        
        let threadGroup = DispatchGroup()
        //推荐数据
        threadGroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":NSDate.getcurrentTime() as NSString]) { (result) in
            //将result转成字典
            guard let resultDict = result as? [String : NSObject] else {return}
            //获取data数组
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //创建组
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict:dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            threadGroup.leave()
        }
        
        //请求第二部分，颜值数据
        threadGroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //将result转成字典
            guard let resultDict = result as? [String : NSObject] else {return}
            //获取data数组
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //创建组
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict:dict)
                self.prettyGroup.anchors.append(anchor)
            }
            threadGroup.leave()
        }
        //请求2-12部分游戏数据
        threadGroup.enter()
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters)  { (result) in
            
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
            threadGroup.leave()
        }
        
        //所有数据都请求到之后进行排序
        threadGroup.notify(queue:DispatchQueue.main){
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
    }
    
    func requestCycleData(finishCallBack : @escaping () -> ()) {
        NetWorkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //获取整体字典数据
            guard let resultDic = result as? [String : NSObject] else {return}
            //根据"data"获取数据
            guard let dataArray = resultDic["data"] as? [[String : NSObject]] else {return}
            
            //字典转模型
            for dict in dataArray{
                self.cycleModels.append(CycleModel(dict: dict))
            }
            
            finishCallBack()
        }
    }
}
