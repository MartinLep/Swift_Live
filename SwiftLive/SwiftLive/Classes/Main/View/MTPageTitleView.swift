//
//  MTPageTitleView.swift
//  MTLive
//
//  Created by MartinLee on 17/3/22.
//  Copyright © 2017年 MartinLee. All rights reserved.
//

import UIKit

protocol MTPageTitleViewDelegate : class {//class只能被类遵守
    func pageTitleView(titleView : MTPageTitleView, selectedIndex index : Int)
}

private let linewidth : CGFloat = 2
private var currentIndex = 0

private let NormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
private let SelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class MTPageTitleView: UIView {

    fileprivate var titles : [String]
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    weak var delegate : MTPageTitleViewDelegate?
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
            
            //给Label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelCliked(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        let buttomLine = UIView()
        buttomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        buttomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(buttomLine)
        
        
        guard let firstLabel = titleLabels.first else { return  }
        firstLabel.textColor = UIColor(r: SelectColor.0, g: SelectColor.1, b: SelectColor.2, alpha: 1)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - linewidth, width: firstLabel.frame.width, height: linewidth)
    }
}


//监听Label的点击
extension MTPageTitleView{
    @objc fileprivate func titleLabelCliked(tapGes : UITapGestureRecognizer){
        //获取当前Label的下标值
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        
        //切换文字的颜色
        oldLabel.textColor = UIColor.darkGray
        currentLabel.textColor = UIColor.orange
        
        
        //保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //滚动条的位置发生改变
        let scrollLineX = CGFloat(currentIndex)*scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}


extension MTPageTitleView{
    func setTitleWithProgress(_ progress : CGFloat,sourceIndex : Int, targetIndex : Int) {
        //取出courceLabel和targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX*progress

        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色的渐变（复杂）
        let colorData = (SelectColor.0 - NormalColor.0,SelectColor.1 - NormalColor.1,SelectColor.2 - NormalColor.2)
        
        //变化sourceLabel
        sourceLabel.textColor = UIColor(r: SelectColor.0 - colorData.0*progress, g: SelectColor.1 - colorData.1*progress, b: SelectColor.2 - colorData.2*progress, alpha: 1)
        
        //变化targetLabel
        
        targetLabel.textColor = UIColor(r: NormalColor.0 + colorData.0*progress, g: NormalColor.1 + colorData.1*progress, b: NormalColor.2 + colorData.2*progress, alpha: 1)
        
        //记录新的index
        currentIndex = targetIndex
    }
}









