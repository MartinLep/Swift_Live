//
//  HomwViewController.swift
//  MTLive
//
//  Created by MartinLee on 17/3/22.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

private let mTitleViewH : CGFloat = 40

class HomwViewController: UIViewController {

    fileprivate lazy var pageTitleView : MTPageTitleView = {
       
        let titleFrame =  CGRect(x: 0, y: mStatusBarH + mNavgationBarH, width: mScreenW, height: mTitleViewH)
    
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let titleView = MTPageTitleView(frame: titleFrame, titles: titles)
        
        return titleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - 设置UI界面
extension HomwViewController{
    fileprivate func setupUI(){
        //不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setNavigationBar()
        
        view.addSubview(pageTitleView)
    }
    
    func setNavigationBar(){
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //设置右边的item
        
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.createItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
//        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
