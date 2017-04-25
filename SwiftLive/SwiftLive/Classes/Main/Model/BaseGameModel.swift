//
//  BaseGameModel.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/24.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    var tag_name : String = ""
    var icon_url : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override init(){
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
