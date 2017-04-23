//
//  CollectionCycleCell.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/16.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
@IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //定义模型属性

    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
             let iconURL = URL(string: cycleModel?.pic_url ?? "")
            iconImageView.kf.setImage(with: iconURL)
        }
    }

}
