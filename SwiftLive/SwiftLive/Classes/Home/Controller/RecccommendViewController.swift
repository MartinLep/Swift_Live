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
private let CycleViewH = mScreenW*3/8
private let GameViewH : CGFloat = 90

class RecccommendViewController: UIViewController {
    
    fileprivate lazy var reccomendViewModel : RecomendViewModel = RecomendViewModel()
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
    
    fileprivate lazy var cycleView : ReccommandCycleView = {
        let cycleView = ReccommandCycleView.reccommendCycltView()
        cycleView.frame = CGRect(x: 0, y: -(CycleViewH + GameViewH), width: mScreenW, height: CycleViewH)
        return cycleView
    }()
    
    fileprivate lazy var gameView : ReccomendGameView = {
        let gameView = ReccomendGameView.reccomendGameView()
        gameView.frame = CGRect(x: 0, y: -GameViewH, width: mScreenW, height: GameViewH)
        return gameView
    }()
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        //发送网络请求
        loadData()
    }
    
    
}



// MARK: - 请求数据
extension RecccommendViewController{
    fileprivate func loadData(){
        reccomendViewModel.requestData {
            self.collectionView.reloadData()
            self.gameView.groups = self.reccomendViewModel.anchorGroups
        }
    
        //轮播数据
        reccomendViewModel.requestCycleData {
            self.cycleView.cycleModels = self.reccomendViewModel.cycleModels
            
        }
    }
}


extension RecccommendViewController{
    fileprivate func setUpUI(){
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(CycleViewH + GameViewH, 0, 0, 0)
    }
}

extension RecccommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return reccomendViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = reccomendViewModel.anchorGroups[section]
        return group.anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出模型对象
        let group = reccomendViewModel.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //定义cell
        var cell : CollectionBaseCell!
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrettyCellID, for: indexPath) as! CollectionPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        cell.anchor = anchor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //取出moxing
        headerView.group = reccomendViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 1){
            return CGSize(width: ItemW, height: PrettyItemH)
        }
        return CGSize(width: ItemW, height: NormalItemH)
    }
    
}
