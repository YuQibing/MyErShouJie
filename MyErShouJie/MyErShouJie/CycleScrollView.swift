//
//  CycleScrollView.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/19.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit

class CycleScrollView: UIView {

    //控件
    fileprivate let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    fileprivate var collectionView: UICollectionView?
    //图片数组
    public var imageArray:[String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Head属性
    fileprivate let count = 5
    fileprivate var pageControl: UIPageControl?
    fileprivate var timer: Timer?
    fileprivate var index: Int = 0
    fileprivate var isScroll: Bool = false
    //监听方法
    @objc fileprivate func cycleTimer(){
        
        if index == count{
            collectionView?.scrollToItem(at: IndexPath(item: 0, section: 2), at:  .centeredHorizontally, animated: true)
            pageControl?.currentPage = 0
            index = 1
            isScroll = true
        }else{
            collectionView?.scrollToItem(at: IndexPath(item: index, section: 1), at: .centeredHorizontally, animated: true)
            pageControl?.currentPage = index
            index += 1
        }
    }
    
    deinit {
        
        timer?.invalidate()
        
    }
}
//初始化（扩展类方法）
extension CycleScrollView {
    
    fileprivate func setupUI(){
        //数据
        imageArray = [String]()
        for i in 0..<count{
            
            imageArray?.append("scroll\(i+1)")
        }
        
        flowLayout.itemSize = bounds.size
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: flowLayout)
        
        guard let collectionView = collectionView else{
            return
        }
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CycleViewCell.self, forCellWithReuseIdentifier: "cycle")
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        
        //滚动到指定位置
        let indexPath = IndexPath(item: 0, section: 1)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        
        pageControl = UIPageControl(frame: CGRect(x: Int((bounds.size.width - 150)/2), y: (Int(bounds.size.height - 40)), width: 150, height: 40))
        pageControl?.numberOfPages = count
        pageControl?.currentPage = 0
        pageControl?.currentPageIndicatorTintColor = UIColor.red
        pageControl?.pageIndicatorTintColor = UIColor.darkGray
        addSubview(pageControl!)
        
    }
    //自动换图片时间设置
    fileprivate func startTimer(){
        timer = Timer(timeInterval: 2, target: self, selector: #selector(self.cycleTimer), userInfo: nil, repeats: true)
        let runloop = RunLoop.current
        runloop.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
}

extension CycleScrollView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cycle", for: indexPath) as! CycleViewCell
        
        cell.imageArray = imageArray
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
            
            collectionView?.scrollToItem(at: IndexPath(item: 0, section: 1), at: .centeredHorizontally, animated: false)
            isScroll = false
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        currentPage = Int(currentPage) % (count)
        pageControl?.currentPage = currentPage
        index = currentPage
        collectionView?.scrollToItem(at: IndexPath(item: currentPage, section: 1), at: .centeredHorizontally, animated: false)
    }
    
}









