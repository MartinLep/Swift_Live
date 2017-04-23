//
//  CollectionBaseCell.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/11.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    //控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickName: UILabel!
    
    //定义模型
    
    var anchor : AnchorModel? {
        didSet{
            //检验模型是否有值
            guard let anchor = anchor else { return }
            
            var onLineStr : String = ""
            
            if anchor.online>=10000 {
                onLineStr = "\(Int(anchor.online / 10000))万人在线"
            }else{
                onLineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onLineStr, for: .normal)
            
            //昵称的显示
            nickName.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
        }
    }

}
