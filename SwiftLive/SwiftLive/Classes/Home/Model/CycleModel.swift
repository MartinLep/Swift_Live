//
//  CycleModel.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/16.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    var title : String = ""
    var pic_url : String = ""
    //主播信息对应的字典
    var anchor : AnchorModel?
    var room : [String : NSObject]? {
        didSet{
            guard let room = room else {return}
            anchor = AnchorModel(dict: room)
        }
    }
    
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
