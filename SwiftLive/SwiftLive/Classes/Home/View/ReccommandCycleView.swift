//
//  ReccommandCycleView.swift
//  SwiftLive
//
//  Created by MartinLee on 17/4/16.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

private let CycleCellId = "CycleCellId"

class ReccommandCycleView: UIView {

    var cycleTimer : Timer?
    var cycleModels : [CycleModel]?{
        didSet{
            collectionView.reloadData()
            
            pageController.numberOfPages = cycleModels?.count ?? 0
            
            //默认滚动到中间某位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            removeCycletimer()
            addCycletimer()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
       
        collectionView.register( UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: CycleCellId)
    
    }
    
    override func layoutSubviews() {
        let layOut = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layOut.itemSize = collectionView.bounds.size
        layOut.minimumLineSpacing = 0
        layOut.minimumInteritemSpacing = 0
        layOut.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }
}

extension ReccommandCycleView{
    class func reccommendCycltView() -> ReccommandCycleView {
        return Bundle.main.loadNibNamed("ReccommandCycleView", owner: nil, options: nil)?.first as! ReccommandCycleView
    }
}

extension ReccommandCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CycleCellId, for: indexPath) as! CollectionCycleCell
        
        let cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        cell.cycleModel = cycleModel
        
        return cell
    }
    
}

extension ReccommandCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + scrollView.bounds.width/2
        pageController.currentPage = Int(offset / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycletimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycletimer()
    }
}

//对定时器的操作方法
extension ReccommandCycleView{
    fileprivate func addCycletimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycletimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext(){
        let currentOffet = collectionView.contentOffset.x
        let offset = currentOffet + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
}
