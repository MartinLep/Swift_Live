//
//  PageContentView.swift
//  SwiftLive
//
//  Created by MartinLee on 17/3/23.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

protocol  PageContentViewDelegate : class{
    func pageContentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellId = "ContentCellId"
class PageContentView: UIView {
    fileprivate var childViewControllers : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0//行间距
        layout.minimumInteritemSpacing = 0//item间距
        layout.scrollDirection = .horizontal//水平滚动
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.isPagingEnabled = true;
        collectionView.bounces = false//不超出内容滚动区域
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        return collectionView
    }()
    
    //自定义构造函数
    init(frame : CGRect, childViewControllers : [UIViewController], parentViewController : UIViewController?){
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
            parentViewController?.addChildViewController(child)
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

extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否是点击事件
        if isForbidScrollDelegate { return }
        
//        定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
//        判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX{ //左滑
            //计算progress
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
//            计算sourceIndex
            sourceIndex = Int(currentOffsetX/scrollViewW)
//            计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childViewControllers.count{
                targetIndex = childViewControllers.count - 1
            }
            //如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{ //右滑
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex = Int(currentOffsetX/scrollViewW)
            //计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childViewControllers.count{
                sourceIndex = childViewControllers.count - 1
            }
        }
        
        //将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
        
    }
}

//对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex : Int) {
        
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex)*collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x : offsetX, y : 0), animated: true)
    }
}



























