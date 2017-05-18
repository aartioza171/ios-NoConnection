//
//  Helper.swift
//  NoInternetConnection
//
//  Created by Aarti Oza on 04/05/17.
//  Copyright © 2017 Aarti Oza. All rights reserved.
//
import UIKit
import Foundation

//MARK: - GENERAL METHODS -


typealias alertAction = (UIAlertAction) -> ()

func showAlertWithTwoButtonTitle(strTitle: String, strMessage: String, strBtn1Title: String, strBtn2Title: String, button1Handler: alertAction?, viewController: UIViewController)
{
    let controller = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertControllerStyle.alert)
    
    let okAction = UIAlertAction(title: strBtn1Title, style: UIAlertActionStyle.default, handler: button1Handler)
    
    let cancelAction = UIAlertAction(title: strBtn2Title, style: UIAlertActionStyle.cancel, handler: nil)
    
    controller.addAction(okAction)
    controller.addAction(cancelAction)
    
    viewController.present(controller, animated: true, completion: nil)
}
