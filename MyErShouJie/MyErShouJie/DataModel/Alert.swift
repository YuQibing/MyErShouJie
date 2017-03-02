//
//  Alert.swift
//  MyErShouJie
//
//  Created by bingbing on 02/03/2017.
//  Copyright © 2017 yuqibing. All rights reserved.
//

import UIKit

class Alert: UIAlertController {
    
    func alertView(message: String, okActionTitle: String, fromViewController: UIViewController, dismissParentViewController: Bool){
        let alertController = UIAlertController(title: "",
                                                message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: {
            action in
            if dismissParentViewController {
            fromViewController.dismiss(animated: true, completion: nil)
            }
            
        })
        
        alertController.addAction(okAction)
        
        fromViewController.present(alertController, animated: true, completion: nil)
    }

}
