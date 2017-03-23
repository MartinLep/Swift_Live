//
//  UIColor+Extension.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/23.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
}
