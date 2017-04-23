//
//  CollectionNormalCell.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/24.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor : AnchorModel? {
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
}
