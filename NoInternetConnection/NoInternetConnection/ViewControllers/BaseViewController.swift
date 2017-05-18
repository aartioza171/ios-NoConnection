//
//  ViewController.swift
//  NoInternetConnection
//
//  Created by Aarti Oza on 21/04/17.
//  Copyright © 2017 Aarti Oza. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController
{
    var noConnectionView : NoConnectionVC = NoConnectionVC()

    //MARK: - VIEW LIFE CYCLE -
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    //MARK: - USER DEFINED METHODS -

    func hideShowInternetConnectionView(_ mainView : UIView, ParentVC : UIViewController,type : Int , msg: String? = nil)
    {
        noConnectionView = storyboard!.instantiateViewController(withIdentifier:"NoConnectionVC") as! NoConnectionVC
        ParentVC.addChildViewController(noConnectionView)
        noConnectionView.intViewType = type
       
        if msg != nil
        {
            noConnectionView.strLblMsg = msg!
        }

        noConnectionView.view.frame = CGRect(x: 0, y: 64, width: mainView.frame.size.width, height: mainView.frame.size.height - 64)
        mainView.addSubview(noConnectionView.view)
        print(noConnectionView.intViewType)
        self.noConnectionView.didMove(toParentViewController: ParentVC)
    }
    
    
    //MARK: - MEMORY MANAGEMENT -
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
