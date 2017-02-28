//
//  HomeProductDetailsController.swift
//  MyErShouJie
//
//  Created by bingbing on 27/02/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit

class HomeProductDetailsController: UIViewController {
    //var listlabel: UILabel?
    var productTitle: String?
    var productPrice: Double?
    var productDescription: String?
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

    private lazy var titlelabel: UILabel = {
        let titlelabel = UILabel()
        titlelabel.backgroundColor = UIColor.red
        //titlelabel.text = productTitle
        return titlelabel
    }()
    
    private lazy var pricelabel: UILabel = {
        let pricelabel = UILabel()
        //pricelabel.text = productPrice as! String
        pricelabel.backgroundColor = UIColor.blue
        return pricelabel
    }()
    
    private lazy var descriptionlabel: UILabel = {
        let descriptionlabel = UILabel()
        //descriptionlabel.text = productDescription
        return descriptionlabel
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsUpdateConstraints()
        self.titlelabel.text = productTitle
        self.pricelabel.text = String(describing: productPrice!)
        print("productTitle = ", productTitle!)
        print("productTitle = ", productPrice!)

        self.view.addSubview(titlelabel)
        self.view.addSubview(pricelabel)
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        pricelabel.translatesAutoresizingMaskIntoConstraints = false
        // Do any additional setup after loading the view.
    }
    
    
    
    override func updateViewConstraints() {
        defer { super.updateViewConstraints() }
        let views = [
            
            "titlelabel": titlelabel,
            "pricelabel": pricelabel,
            "descriptionlabel": descriptionlabel
            ] as [String : Any]
        
        let metrics = [
            "titleLabelHeight": Constraints.titleLabelHeight,
            "titleLabelWidth": Constraints.screenWidth - 100,
            "priceLabelHeight": Constraints.priceLabelHeight,
            "priceLabelWeight": Constraints.priceLabelWeidth,
            "descriptionLabelHeight": Constraints.descriptionLabelHeight,
            "horizontalLineHeight": Constraints.horizontalLineHeight,
            "sidepadding": Constraints.sidepadding
            ] as [String : Any]
        
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(sidepadding)-[titlelabel(titleLabelWidth)]-(0)-[pricelabel]-(sidepadding)-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(64)-[titlelabel(priceLabelHeight)]", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(64)-[pricelabel(priceLabelHeight)]", metrics: metrics, views: views))
        
        NSLayoutConstraint.activate(customConstraints)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
