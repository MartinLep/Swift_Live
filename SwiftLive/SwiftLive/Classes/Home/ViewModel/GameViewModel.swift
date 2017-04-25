//
//  GameViewModel.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/24.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel{
    func loadAllGameData(finishedCallBack : @escaping () -> ()) {
        NetWorkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            guard let resultDict = result as? [String : Any] else {return}
            guard let dataArray = resultDict["data"] as? [[String : Any]] else {return}
            
//            字典转模型
            for dict in dataArray{
                self.games.append(GameModel(dict: dict))
            }
            
            finishedCallBack()
        }
    }
}
