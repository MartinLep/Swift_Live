//
//  RecccommendViewController.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/24.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit


private let ItemMargin : CGFloat = 10
private let ItemW = (mScreenW - 3*ItemMargin)/2
private let NormalItemH = 3*ItemW/4
private let PrettyItemH = 4*ItemW/3
private let NormalCellID = "NarmalCellId"
private let PrettyCellID = "PrettyCellID"
private let NHeaderViewID = "NHeaderViewID"
private let HeaderViewH = 50

class RecccommendViewController: UIViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
       //创建布局
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ItemW, height: NormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = ItemMargin
        layout.headerReferenceSize = CGSize(width: mScreenW, height: 50)
        layout.sectionInset = UIEdgeInsetsMake(0, ItemMargin, 0, ItemMargin)
        //创建UICollectionView
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.dataSource  = self
        
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionNormalCell",bundle: nil), forCellWithReuseIdentifier: NormalCellID)
        
        
        collectionView.register(UINib(nibName: "CollectionPrettyCell",bundle: nil), forCellWithReuseIdentifier: PrettyCellID)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView",bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NHeaderViewID)
        //随父空间的大小而变化
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        return collectionView
    }()
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }


}


extension RecccommendViewController{
    fileprivate func setUpUI(){
        view.addSubview(collectionView)
    }
}

extension RecccommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 8
        }else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell!
            
        if indexPath.section == 1{
           cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrettyCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath)
        }
        
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NHeaderViewID, for: indexPath)

        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1){
            return CGSize(width: ItemW, height: PrettyItemH)
        }
        return CGSize(width: ItemW, height: NormalItemH)
    }
    
}
