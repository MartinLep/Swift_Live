//
//  MTPageTitleView.swift
//  MTLive
//
//  Created by MartinLee on 17/3/22.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

private let linewidth : CGFloat = 2

class MTPageTitleView: UIView {

    fileprivate var titles : [String]
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    /// 懒加载属性
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.scrollsToTop = false;
        scrollView.isPagingEnabled = false;
        scrollView.bounces = false;
        return scrollView;
    }()
    
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //自定义构造函数
    init(frame: CGRect,titles : [String] ) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - 设置UI界面
extension MTPageTitleView{
    fileprivate func setupUI(){
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加title对应的Label
        setupTitleLabels()
        
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels(){
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - linewidth
        let labelY : CGFloat = 0
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            
            let labelX : CGFloat = labelW*CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)

            //添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        let buttomLine = UIView()
        buttomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        buttomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(buttomLine)
        
        
        guard let firstLabel = titleLabels.first else { return  }
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - linewidth, width: firstLabel.frame.width, height: linewidth)
    }
}














