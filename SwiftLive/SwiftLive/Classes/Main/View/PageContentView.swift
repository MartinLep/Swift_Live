//
//  PageContentView.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/23.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

private let ContentCellId = "ContentCellId"
class PageContentView: UIView {
    fileprivate var childViewControllers : [UIViewController]
    fileprivate var parentViewController : UIViewController
    
    fileprivate lazy var collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0//行间距
        layout.minimumInteritemSpacing = 0//item间距
        layout.scrollDirection = .horizontal//水平滚动
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.isPagingEnabled = true;
        collectionView.bounces = false//不超出内容滚动区域
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        return collectionView
    }()
    
    //自定义构造函数
    init(frame : CGRect, childViewControllers : [UIViewController], parentViewController : UIViewController){
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//设置UI界面

extension PageContentView{
    fileprivate func setUpUI(){
        //将所有的字控制器添加到父控制器中
        for child in childViewControllers{
            parentViewController.addChildViewController(child)
        }
        
        //添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let child = childViewControllers[indexPath.item]
        child.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(child.view)
        return cell
    }
}





























