//
//  CollectionPrettyCell.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/24.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet{
            super.anchor = anchor
            //城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}

