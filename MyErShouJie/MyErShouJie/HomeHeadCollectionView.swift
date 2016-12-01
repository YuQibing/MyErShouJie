//
//  HomeHeadCollectionView.swift
//  MyErShouJie
//
//  Created by bingbing on 16/11/20.
//  Copyright © 2016年 yuqibing. All rights reserved.
//

import UIKit
import SnapKit

class HomeHeadCollectionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 控件
    
    fileprivate lazy var collectionView:UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSize(width: ScreenWidth/4, height:self.bounds.size.height/2)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth/2), collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeHeadCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    //指示器
    fileprivate let IndicatorView = UILabel()
    
    fileprivate let item:CGFloat = 16
    
}

extension HomeHeadCollectionView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(item)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeHeadCollectionViewCell
        
        
        cell.indexPath = indexPath
        
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        IndicatorView.isHidden = false
        //更新约束
        UIView.animate(withDuration: 0.3) {
            
            self.IndicatorView.frame = CGRect(x: page * (ScreenWidth / (self.item / 8)), y: self.bounds.size.height - self.IndicatorView.bounds.size.height - 2, width: (ScreenWidth / (self.item / 8)), height: 2)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.IndicatorView.isHidden = true
        
    }
    
    
}


extension HomeHeadCollectionView {
    
    fileprivate func setupUI(){
        
        addSubview(collectionView)
        addSubview(IndicatorView)
        IndicatorView.backgroundColor = UIColor.blue
        IndicatorView.isHidden = true
        IndicatorView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.bottom.equalTo(self).offset(-2)
            make.width.equalTo(ScreenWidth / (item / 8))
            make.height.equalTo(2)
        }
    }
    
}

