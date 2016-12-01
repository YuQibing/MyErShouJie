//
//  HomeTextScrollView.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/21.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class HomeTextScrollView: UIView {
    
    //控件
    fileprivate let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    fileprivate var collectionView:UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //属性
    fileprivate var timer:Timer?
    fileprivate var index:Int = 0
    fileprivate var isScroll:Bool = false
    //文本数组
    public var textArray:[String]?
    
    //监听方法
    @objc fileprivate func cycleTimer(){
        
        if index == textArray?.count{
            collectionView?.scrollToItem(at: IndexPath(item: 0, section: 2), at: .centeredVertically, animated: true)
            index = 1
            isScroll = true
        }else{
            
            collectionView?.scrollToItem(at: IndexPath(item: index, section: 1), at: .centeredVertically, animated: true)
            
            index += 1
        }
    }
    
    deinit {
        
        timer?.invalidate()
    }
}
extension HomeTextScrollView {
    
    fileprivate func setupUI(){
        backgroundColor = superview?.backgroundColor
        //测试数据
        textArray = ["数码产品","二手包包","二手书籍","体育用品","交通工具","杂货"]
        
        flowLayout.itemSize = bounds.size
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        
        guard let collectionView = collectionView else{
            return
        }
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = superview?.backgroundColor
        collectionView.bounces = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeTextScrollCell.self, forCellWithReuseIdentifier: "text")
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
        //滚到指定位置
        let indexPath = IndexPath(item: 0, section: 1)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
        
        startTimer()
    }
    
    fileprivate func startTimer(){
        
        timer = Timer(timeInterval: 2, target: self, selector: #selector(self.cycleTimer), userInfo: nil, repeats: true)
        let runloop = RunLoop.current
        runloop.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
}

//数据源,代码方法
extension HomeTextScrollView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (textArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "text", for: indexPath) as! HomeTextScrollCell
        
        cell.textArray = textArray
        
        cell.indexPath = indexPath
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        timer?.invalidate()
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        startTimer()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        //判断是否滚到第三组第一个
        if isScroll{
            
            collectionView?.scrollToItem(at: IndexPath(item: 0, section: 1), at: .centeredVertically, animated: false)
            
            isScroll = false
        }
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width);
        
        currentPage = Int(currentPage) % (textArray?.count)!
        
        index = currentPage
        
        collectionView?.scrollToItem(at: IndexPath(item: currentPage, section: 1), at: .centeredVertically, animated: false)
        
    }
    
    
}

