//
//  CollectionHeaderView.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/24.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    //定义模型属性
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}
