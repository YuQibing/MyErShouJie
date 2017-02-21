//
//  PostController.swift
//  MyErShouJie
//
//  Created by bingbing on 14/02/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit
//import QBImagePickerController
import DKImagePickerController

class PostController: UIViewController, UINavigationControllerDelegate{
    var navigationBar: UINavigationBar?
    
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
        navigationItem.title = "发布"
        navigationItem.setRightBarButton(dismissButton, animated: true)
        navigationbar.pushItem(navigationItem, animated: true)
        return navigationbar
    }()
    private lazy var titleText: UITextField = {
        let titleText = UITextField()
        //titleText.borderStyle = UITextBorderStyle.bezel
        titleText.placeholder = "标题 物品的品牌型号"
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
        descriptiontext.text = "物品描述"
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

    private lazy var photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.backgroundColor = UIColor.cyan
        return photoView
    }()
    
    private lazy var photoView1: UIImageView = {
        let photoView = UIImageView()
        photoView.backgroundColor = UIColor.cyan
        return photoView
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
        self.view.addSubview(photoView)
        self.view.addSubview(photoView1)
        
        newNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        titleText.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        //takephotoButton.translatesAutoresizingMaskIntoConstraints = false
        selectphotoButton.translatesAutoresizingMaskIntoConstraints = false
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView1.translatesAutoresizingMaskIntoConstraints = false
        
        
        
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
            "photoView": photoView,
            "photoView1": photoView1
            
        ] as [String : Any]
        
        let metrics = [
            "smallButtonSize": Constraints.smallButtonSize,
            "largeButtonSize": Constraints.largeButtonSize,
            "titleTextHeight": Constraints.titleTextHeight,
            "descriptionTextHeight": Constraints.descriptionTextHeight,
            "horizontalLineHeight": Constraints.horizontalLineHeight,
            "sidePadding": 10,
            "buttonSidePadding": 5,
            "sideParentPadding": 70,
            "navigationBarWidth": ScreenWidth,
            "navigationBarHeight": 64,
            "photoViewSize": Constraints.photoViewSize
            
            

        ] as [String : Any]
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[newnavigationBar]-(0)-|", options:NSLayoutFormatOptions.alignAllTop, metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-[newnavigationBar(navigationBarHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[titleText]-|",  metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[newnavigationBar]-(sidePadding)-[titleText(titleTextHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[horizontalLine]-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[titleText]-[horizontalLine(horizontalLineHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[descriptionText]-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[horizontalLine]-[descriptionText(descriptionTextHeight)]", metrics: metrics, views: views))
    
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[selectphotoButton(smallButtonSize)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[descriptionText]-[selectphotoButton(smallButtonSize)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[photoView(photoViewSize)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[selectphotoButton]-[photoView(photoViewSize)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[photoView]-(sidePadding)-[photoView1(photoViewSize)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[selectphotoButton]-[photoView1(photoViewSize)]", metrics: metrics, views: views))
        
        
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
    
    
    
 
    var assets: [DKAsset]?
    func selectPhoto() {
        let pickerController = DKImagePickerController()
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            
            self.assets = assets
            print("images count = ", assets)
        }
        self.present(pickerController, animated: true, completion: nil)
        
    }
    
    
    
   

}
