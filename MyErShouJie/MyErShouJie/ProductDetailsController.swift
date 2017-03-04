//
//  HomeProductDetailsController.swift
//  MyErShouJie
//
//  Created by bingbing on 27/02/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit
import DKImagePickerController
import Alamofire

class ProductDetailsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //var listlabel: UILabel?
    var productTitle: String?
    var productPrice: Double?
    var productDescription: String?
    var imagesUrl: Array<String> = []
    var collectionView: UICollectionView?
    private var customConstraints: [NSLayoutConstraint] = []
    
    private struct Constraints {
        static let titleLabelHeight = 100
        static let priceLabelHeight = 40
        static let priceLabelWeidth = 50
        static let descriptionLabelHeight = 300
        static let horizontalLineHeight = 0.5
        static let sidepadding = 5
        static let screenWidth = UIScreen.main.bounds.width
        
    }

    private lazy var titleLabel: UILabel = {
        let titlelabel = UILabel()
        return titlelabel
    }()
    
    private lazy var priceLabel: UILabel = {
        let pricelabel = UILabel()
        return pricelabel
    }()
    
    private lazy var horizontalLine: UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = UIColor.lightGray
        return horizontalLine
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionlabel = UILabel()
        return descriptionlabel
    }()
    
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let imageCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        imageCollectionView.isScrollEnabled = false
        imageCollectionView.register(ProductDetailsCollectionViewCell.self, forCellWithReuseIdentifier: "imageCollectionView")
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        return imageCollectionView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsUpdateConstraints()
        self.titleLabel.text = productTitle!
        self.priceLabel.text = "¥ "+String(describing: productPrice!)
        self.view.addSubview(titleLabel)
        self.view.addSubview(priceLabel)
        self.view.addSubview(horizontalLine)
        self.view.addSubview(imageCollectionView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func updateViewConstraints() {
        defer { super.updateViewConstraints() }
        let views = [
            "titleLabel": titleLabel,
            "priceLabel": priceLabel,
            "descriptionLabel": descriptionLabel,
            "horizontalLine": horizontalLine,
            "imageCollectionView": imageCollectionView
            ] as [String : Any]
        
        let metrics = [
            "titleLabelHeight": Constraints.titleLabelHeight,
            "titleLabelWidth": Constraints.screenWidth - 100,
            "priceLabelHeight": Constraints.priceLabelHeight,
            "priceLabelWeight": Constraints.priceLabelWeidth,
            "descriptionLabelHeight": Constraints.descriptionLabelHeight,
            "horizontalLineHeight": Constraints.horizontalLineHeight,
            "sidepadding": Constraints.sidepadding,
            "collectionViewHeight": 200 * (imagesUrl.count)
            ] as [String : Any]
        print("imagesUrl.count = ", imagesUrl.count)
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidepadding)-[titleLabel(titleLabelWidth)]-(0)-[priceLabel]-(sidepadding)-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(64)-[titleLabel(priceLabelHeight)]-[horizontalLine(horizontalLineHeight)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(64)-[priceLabel(priceLabelHeight)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidepadding)-[horizontalLine]-(sidepadding)-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidepadding)-[imageCollectionView]-(sidepadding)-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[horizontalLine]-[imageCollectionView(collectionViewHeight)]", metrics: metrics, views: views))
        NSLayoutConstraint.activate(customConstraints)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat (collectionView.frame.size.width  ), height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionView", for: indexPath) as! ProductDetailsCollectionViewCell
        let imageView = cell.images! as UIImageView
        for index in 0...imagesUrl.count - 1 {
            imageView.hnk_setImage(from: URL(string: baseUrl + imagesUrl[index]))
        }
        return cell
    }
}
