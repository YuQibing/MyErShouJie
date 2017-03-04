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
class PostController: UIViewController, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    var images = Array<UIImage>()
    var assets: [DKAsset]?
    lazy public var UIDelegate: DKImagePickerControllerUIDelegate = {
        return DKImagePickerControllerDefaultUIDelegate()
    }()
    
    private var customConstraints: [NSLayoutConstraint] = []
    private struct Constraints {
        static let smallButtonSize = 60
        static let largeButtonSize = 120
        static let titleTextHeight = 30
        static let descriptionTextHeight = 80
        static let horizontalLineHeight = 0.5
        static let photoViewSize = 80
    }
    
    private lazy var navigationBar: UINavigationBar =  {
        let navigationBar = UINavigationBar()
        navigationBar.barStyle = UIBarStyle.default
        let navigationItem = UINavigationItem()
        let dismissButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(PostController.dismiss as (PostController) -> () -> ()))
        let postButton = UIBarButtonItem(title: "Upload", style: UIBarButtonItemStyle.done, target: self, action: #selector(PostController.upload))
        navigationItem.title = "发布"
        navigationItem.setLeftBarButton(dismissButton, animated: true)
        navigationItem.setRightBarButton(postButton, animated: true)
        navigationBar.pushItem(navigationItem, animated: true)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    private lazy var titleText: UITextField = {
        let titleText = UITextField()
        //titleText.borderStyle = UITextBorderStyle.bezel
        titleText.placeholder = "标题 物品的品牌型号"
        titleText.delegate = self
        titleText.translatesAutoresizingMaskIntoConstraints = false
        return titleText
    }()
    private lazy var horizontalLine: UIView = {
        let horizontalLine = UIView()
        horizontalLine.backgroundColor = UIColor.lightGray
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        return horizontalLine
    }()
    private lazy var descriptionText: UITextView = {
        let descriptionText = UITextView()
        descriptionText.textAlignment = NSTextAlignment.left
        //descriptionText.layer.borderWidth = 0.5
        descriptionText.text = "物品描述"
        descriptionText.layer.borderColor = UIColor.gray.cgColor
        descriptionText.font = UIFont.systemFont(ofSize: 16)
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        return descriptionText
    }()
    private lazy var selectphotoButton: UIButton = {
        let selectphotoButton = UIButton()
        selectphotoButton.setImage(UIImage(named: "post"), for: .normal)
        selectphotoButton.addTarget(self, action: #selector(PostController.selectPhoto), for: .touchUpInside)
        selectphotoButton.layer.borderWidth = 0.5
        selectphotoButton.backgroundColor = UIColor.lightGray
        selectphotoButton.translatesAutoresizingMaskIntoConstraints = false
        return selectphotoButton
    }()

    private lazy var previewImages: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let previewImages = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        previewImages.register(PostPreviewImagesCell.self, forCellWithReuseIdentifier: "previewimages")
        previewImages.delegate = self
        previewImages.dataSource = self
        previewImages.backgroundColor = UIColor.gray
        previewImages.translatesAutoresizingMaskIntoConstraints = false
        return previewImages
    }()
    
    private lazy var priceText: UITextField = {
        let priceText = UITextField()
        //titleText.borderStyle = UITextBorderStyle.bezel
        priceText.placeholder = "你想卖多少钱"
        priceText.keyboardType = UIKeyboardType.numberPad
        priceText.returnKeyType = .done
        priceText.delegate = self
        priceText.translatesAutoresizingMaskIntoConstraints = false
        return priceText
    }()
    
    private lazy var typePicker: UIPickerView = {
        let typePicker = UIPickerView()
        typePicker.translatesAutoresizingMaskIntoConstraints = false
        typePicker.delegate = self
        typePicker.dataSource = self
        return typePicker
    }()
    
    private lazy var pricehorizontalLine: UIView = {
        let pricehorizontalLine = UIView()
        pricehorizontalLine.backgroundColor = UIColor.lightGray
        pricehorizontalLine.translatesAutoresizingMaskIntoConstraints = false
        return pricehorizontalLine
    }()
    
    private lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = "商品类型"
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        return typeLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PostController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        self.view.setNeedsUpdateConstraints()
        self.view.addSubview(navigationBar)
        self.view.addSubview(titleText)
        self.view.addSubview(horizontalLine)
        self.view.addSubview(descriptionText)
        self.view.addSubview(selectphotoButton)
        self.view.addSubview(previewImages)
        self.view.addSubview(priceText)
        self.view.addSubview(pricehorizontalLine)
        self.view.addSubview(typePicker)
        self.view.addSubview(typeLabel)
    }
    override func updateViewConstraints() {
        defer { super.updateViewConstraints() }
        let views = [
            //"takephotoButton": takephotoButton,
            "selectphotoButton": selectphotoButton,
            "titleText": titleText,
            "descriptionText": descriptionText,
            "navigationBar": navigationBar,
            "horizontalLine": horizontalLine,
            "previewImages": previewImages,
            "priceText": priceText,
            "pricehorizontalLine": pricehorizontalLine,
            "typePicker": typePicker,
            "typeLabel": typeLabel
            
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
            "width": ScreenWidth - 20,
            "photoViewSize": Constraints.photoViewSize
        ] as [String : Any]
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:[navigationBar(navigationBarWidth)]", options:NSLayoutFormatOptions.alignAllTop, metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[navigationBar(navigationBarHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[titleText(width)]",  metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[navigationBar]-(sidePadding)-[titleText(textHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[horizontalLine(width)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[titleText]-[horizontalLine(horizontalLineHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[descriptionText(width)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[horizontalLine]-[descriptionText(descriptionTextHeight)]", metrics: metrics, views: views))
    
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[selectphotoButton(smallButtonSize)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[descriptionText]-[selectphotoButton(smallButtonSize)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[previewImages(width)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[selectphotoButton]-[previewImages(previewImagesHeight)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[priceText(width)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:[previewImages]-(sidePadding)-[priceText(textHeight)]-[pricehorizontalLine(horizontalLineHeight)]-[typeLabel(10)]-[typePicker(100)]", metrics: metrics, views: views))
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidePadding)-[pricehorizontalLine(width)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[typePicker]-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-[typeLabel]-|", metrics: metrics, views: views))
 
        NSLayoutConstraint.activate(customConstraints)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dismiss() {
        
        dismiss(animated: true, completion: nil)
    }
    
    func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
    
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
    //价格文本框 弹出键盘 View上移
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let frame:CGRect = textField.frame
        let offset:CGFloat = frame.origin.y + 30 - (self.view.frame.size.height-216)
        if offset > 0  {
            self.view.frame = CGRect(x:0.0, y:-offset, width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame = CGRect(x:0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {      
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 10 ), height: CGFloat((collectionView.frame.size.width / 3)))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let asset = self.assets![indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previewimages", for: indexPath) as! PostPreviewImagesCell
        asset.fetchFullScreenImage(false, completeBlock: { image, info in
            
            print("images = ", info!)
            if self.images.count == 0 {
                self.images = Array<UIImage>()
            }
//            let ImageUrlValue = info!["PHImageFileURLKey"] as! NSURL
//            let ImageUrlString = ImageUrlValue.absoluteString?.replacingOccurrences(of: "file://", with: "")
//            let selectImage = UIImage(contentsOfFile: ImageUrlString!)
            self.images.append(image!)
            //print("ImageUrlString = ", ImageUrlString!)
            cell.imageView?.image = image
            //cell.imageView?.image = UIImage(contentsOfFile: ImageUrlString!)
            
        })
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return productType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return productType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
    }
    
    func upload() {
        let serverAPI = ServerAPI()
        let paramsTitleValue = titleText.text!
        let paramsDescriptionValue = descriptionText.text!
        let paramsPriceValue = priceText.text!
        let paramsTypeValue = typePicker.selectedRow(inComponent: 0) + 1
        let alertView = Alert()
        print("pricetext = ", priceText.text!)
        var alertMessage = ""
        if (titleText.text! == "") {
            alertMessage = "标题"
        } else if (priceText.text! == "") {
            alertMessage = "价格"
        } else if (descriptionText.text! == "") {
            alertMessage = "物品描述"
        } else if (self.images.count == 0) {
            alertMessage = "图片"
        }
        
        if alertMessage != "" {
            alertView.alertView(message: alertMessage+"不能为空", okActionTitle: "好的", fromViewController: self, dismissParentViewController: false)
            return
        }
        let params: [String:String] = ["title": paramsTitleValue, "price": paramsPriceValue, "description": paramsDescriptionValue, "type": String(paramsTypeValue)]

        serverAPI.upLoad(params: params,paramsImages: images, success: { response in
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
