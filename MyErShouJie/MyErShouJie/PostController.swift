//
//  PostController.swift
//  MyErShouJie
//
//  Created by bingbing on 14/02/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit
import SwiftyJSON
import DKImagePickerController
import Photos
class PostController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var navigationBar: UINavigationBar?
    var collectionView: UICollectionView!
    var imageUrls: Array<String>!
    var assets: [DKAsset]?
    
    
    lazy public var UIDelegate: DKImagePickerControllerUIDelegate = {
        return DKImagePickerControllerDefaultUIDelegate()
    }()
    
    private var customConstraints: [NSLayoutConstraint] = []
    private struct Constraints {
        static let smallButtonSize = 60
        static let largeButtonSize = 120
        static let titleTextHeight = 30
        static let descriptionTextHeight = 100
        static let horizontalLineHeight = 0.5
        static let photoViewSize = 80
    }
    private lazy var newNavigationBar: UINavigationBar =  {
        let navigationbar = UINavigationBar()
        navigationbar.barStyle = UIBarStyle.default
        let navigationItem = UINavigationItem()
        let dismissButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(PostController.dismiss as (PostController) -> () -> ()))
        let postButton = UIBarButtonItem(title: "Upload", style: UIBarButtonItemStyle.done, target: self, action: #selector(PostController.upload))
        navigationItem.title = "发布"
        navigationItem.setLeftBarButton(dismissButton, animated: true)
        navigationItem.setRightBarButton(postButton, animated: true)
        navigationbar.pushItem(navigationItem, animated: true)
        return navigationbar
    }()
    private lazy var titleText: UITextField = {
        let titleText = UITextField()
        //titleText.borderStyle = UITextBorderStyle.bezel
        titleText.placeholder = "标题 物品的品牌型号"
        titleText.text = "title"
        return titleText
    }()
    private lazy var horizontalLine: UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = UIColor.lightGray
        return horizontalLine
    }()
    private lazy var descriptionText: UITextView = {
        let descriptiontext = UITextView()
        descriptiontext.textAlignment = NSTextAlignment.left
        //descriptionText.layer.borderWidth = 0.5
        descriptiontext.layer.borderColor = UIColor.gray.cgColor
        descriptiontext.font = UIFont.systemFont(ofSize: 16)
        descriptiontext.text = "1"
        return descriptiontext
    }()
//    private lazy var takephotoButton: UIButton = {
//        let takephotobutton = UIButton()
//        takephotobutton.setImage(UIImage(named: "Class"), for: .normal)
//        takephotobutton.addTarget(self, action: #selector(PostController.takePhoto), for: .touchUpInside)
//        takephotobutton.layer.borderWidth = 0.5
//        takephotobutton.backgroundColor = UIColor.lightGray
//        return takephotobutton
//    }()
    private lazy var selectphotoButton: UIButton = {
        let selectphotobutton = UIButton()
        selectphotobutton.setImage(UIImage(named: "post"), for: .normal)
        selectphotobutton.addTarget(self, action: #selector(PostController.selectPhoto), for: .touchUpInside)
        selectphotobutton.layer.borderWidth = 0.5
        selectphotobutton.backgroundColor = UIColor.lightGray
        return selectphotobutton
    }()

    private lazy var previewImages: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let previewImages = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        previewImages.register(PostPreviewImagesCell.self, forCellWithReuseIdentifier: "previewimages")
        previewImages.delegate = self
        previewImages.dataSource = self
        previewImages.backgroundColor = UIColor.gray
        return previewImages
    }()
    
    private lazy var priceText: UITextField = {
        let priceText = UITextField()
        //titleText.borderStyle = UITextBorderStyle.bezel
        priceText.placeholder = "你想卖多少钱"
        priceText.text = "100"
        return priceText
        
        
    }()
    
    private lazy var pricehorizontalLine: UIView = {
        let pricehorizontalLine = UIView()
        pricehorizontalLine.backgroundColor = UIColor.lightGray
        return pricehorizontalLine
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.view.setNeedsUpdateConstraints()
        self.view.addSubview(newNavigationBar)
        self.view.addSubview(titleText)
        self.view.addSubview(horizontalLine)
        self.view.addSubview(descriptionText)
        //self.view.addSubview(takephotoButton)
        self.view.addSubview(selectphotoButton)
        self.view.addSubview(previewImages)
        self.view.addSubview(priceText)
        self.view.addSubview(pricehorizontalLine)
        
        newNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        //takephotoButton.translatesAutoresizingMaskIntoConstraints = false
        selectphotoButton.translatesAutoresizingMaskIntoConstraints = false
        previewImages.translatesAutoresizingMaskIntoConstraints = false
        priceText.translatesAutoresizingMaskIntoConstraints = false
        pricehorizontalLine.translatesAutoresizingMaskIntoConstraints = false
    }
    override func updateViewConstraints() {
        defer { super.updateViewConstraints() }
        let views = [
            //"takephotoButton": takephotoButton,
            "selectphotoButton": selectphotoButton,
            "titleText": titleText,
            "descriptionText": descriptionText,
            "newnavigationBar": newNavigationBar,
            "horizontalLine": horizontalLine,
            "previewImages": previewImages,
            "priceText": priceText,
            "pricehorizontalLine": pricehorizontalLine
            
        ] as [String : Any]
        
        let metrics = [
            "smallButtonSize": Constraints.smallButtonSize,
            "largeButtonSize": Constraints.largeButtonSize,
            "textHeight": Constraints.titleTextHeight,
            "descriptionTextHeight": Constraints.descriptionTextHeight,
            "horizontalLineHeight": Constraints.horizontalLineHeight,
            "sidePadding": 10,
            "buttonSidePadding": 5,
            "sideParentPadding": 70,
            "navigationBarWidth": ScreenWidth,
            "navigationBarHeight": 64,
            "previewImagesHeight": 200,
            "photoViewSize": Constraints.photoViewSize
        ] as [String : Any]
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[newnavigationBar]-(0)-|", options:NSLayoutFormatOptions.alignAllTop, metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-[newnavigationBar(navigationBarHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[titleText]-|",  metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[newnavigationBar]-(sidePadding)-[titleText(textHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[horizontalLine]-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[titleText]-[horizontalLine(horizontalLineHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[descriptionText]-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[horizontalLine]-[descriptionText(descriptionTextHeight)]", metrics: metrics, views: views))
    
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[selectphotoButton(smallButtonSize)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[descriptionText]-[selectphotoButton(smallButtonSize)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[previewImages]-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[selectphotoButton]-[previewImages(previewImagesHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[priceText]-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[previewImages]-(sidePadding)-[priceText(textHeight)]-[pricehorizontalLine(horizontalLineHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[pricehorizontalLine]-|", metrics: metrics, views: views))
        
        
        NSLayoutConstraint.activate(customConstraints)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func dismiss() {
        
        dismiss(animated: true, completion: nil)
    }
    
    
//    func takePhoto() {
//        let takephoto = UIImagePickerController()
//        takephoto.delegate = self
//        takephoto.sourceType = UIImagePickerControllerSourceType.camera
//        self.present(takephoto, animated: true, completion: nil)
//    }
    
//    func selectPhoto() {
//        let selectphoto = DKImagePickerController()
//        selectphoto.allowMultipleTypes = true
//        selectphoto.maxSelectableCount = 3
//        selectphoto.showsCancelButton = true
//        self.present(selectphoto, animated: true, completion: nil)
//        
//    }

    
    func selectPhoto() {
        let pickerController = DKImagePickerController()
        pickerController.defaultSelectedAssets = self.assets
        pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
            
            self.assets = assets
            print("images count = ", assets)
            self.previewImages.reloadData()
        }
        self.present(pickerController, animated: true, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 10  
//        
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 10 ), height: CGFloat((collectionView.frame.size.width / 3)))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let asset = self.assets![indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previewimages", for: indexPath) as! PostPreviewImagesCell
        let imageView = cell.images! as UIImageView
        asset.fetchFullScreenImage(false, completeBlock: { image, info in
            
            print("images = ", info!)
            if self.imageUrls == nil {
                self.imageUrls = Array<String>()
            }
            let ImageUrlValue = info!["PHImageFileURLKey"] as! NSURL
            let ImageUrlString = ImageUrlValue.absoluteString?.replacingOccurrences(of: "file://", with: "")

            self.imageUrls?.append(ImageUrlString!)
            imageView.image = image
            
        })
        return cell
    }
    
    
    
    func upload() {
        let serverAPI = ServerAPI()
        let paramsTitleValue = titleText.text!
        let paramsDescriptionValue = descriptionText.text!
        let paramsPriceValue = priceText.text!
        let alertView = Alert()
        print("pricetext = ", priceText.text!)
        var alertMessage = ""
        if (titleText.text! == "") {
            alertMessage = "标题"
        } else if (priceText.text! == "") {
            alertMessage = "价格"
        } else if (descriptionText.text! == "") {
            alertMessage = "物品描述"
        } else if (self.imageUrls == nil) {
            alertMessage = "图片"
        }
        
        if alertMessage != "" {
            alertView.alertView(message: alertMessage+"不能为空", okActionTitle: "好的", fromViewController: self, dismissParentViewController: false)
            return
        }
        let params: [String:String] = ["title": paramsTitleValue, "price": paramsPriceValue, "description": paramsDescriptionValue, "type": "1" ]

        serverAPI.upLoad(params: params,paramsImageUrls: imageUrls!, success: { response in
            let json = JSON(response)
            print("return json = ", json)
            let alertUploadSuccess = Alert()
            alertUploadSuccess.alertView(message: "上传成功", okActionTitle: "好的", fromViewController: self, dismissParentViewController: true)
        }, failure: { error in
            print("return error = ", error)
            let alertUploadFailure = Alert()
            alertUploadFailure.alertView(message: "上传失败", okActionTitle: "好的", fromViewController: self, dismissParentViewController: false)
        })
        
        
    }
    
    
}
