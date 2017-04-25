//
//  GameViewController.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/24.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

private let EdgeMargin : CGFloat = 10
private let ItemW : CGFloat = (mScreenW - 2*EdgeMargin)/3
private let ItemH : CGFloat = ItemW*6/5

private let GameCellID = "GameCellID"
class GameViewController: UIViewController {
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ItemW, height: ItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, EdgeMargin, 0, EdgeMargin)
        
       let collectionView  = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: GameCellID)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        setUpUI()
        
        loadData()
    }

}

extension GameViewController{
    fileprivate func setUpUI(){
        view.addSubview(collectionView)
    }
    
    fileprivate func loadData(){
        gameVM.loadAllGameData { 
            self.collectionView.reloadData()
        }
    }
}

extension GameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCellID, for: indexPath) as! CollectionGameCell
        let gameModel = gameVM.games[indexPath.item]
        cell.group = gameModel
        
        return cell
    }
}

extension GameViewController : UICollectionViewDelegate{
    
}
