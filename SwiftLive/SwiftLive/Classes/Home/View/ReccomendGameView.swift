//
//  ReccomendGameView.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/17.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

private let GameViewCellId = "GameViewCellId"

class ReccomendGameView: UIView {
    //定义数据属性
    
    var groups : [AnchorGroup]? {
        didSet{
            groups?.removeFirst()
            groups?.removeFirst()
            
            //添加更多
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: GameViewCellId)
        
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
    }
}

extension ReccomendGameView{
    class func reccomendGameView() -> ReccomendGameView{
        return Bundle.main.loadNibNamed("ReccomendGameView", owner: nil, options: nil)?.first as! ReccomendGameView
    }
}


extension ReccomendGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameViewCellId, for: indexPath) as! CollectionGameCell
        
        cell.group = groups![indexPath.item]
        
        
        return cell
    }
}
