//
//  CollectionGameCell.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/17.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var group : BaseGameModel?{
        didSet{
            titlelabel.text = group?.tag_name
            let url = URL(string: group?.icon_url ?? "")
            iconImageView.kf.setImage(with: url,placeholder: UIImage(named: "home_more_btn"))
        }
    }

}
				
