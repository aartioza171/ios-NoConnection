 //
//  ViewController.swift
//  NoInternetConnection
//
//  Created by Aarti Oza on 21/04/17.
//  Copyright © 2017 Aarti Oza. All rights reserved.
//

import UIKit

class Screen1VC: BaseViewController
{
    //MARK: - VIEW LIFE CYCLE -
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        showAlertWithTwoButtonTitle(strTitle: APPNAME, strMessage: "Webservice screen with no connection screen.", strBtn1Title: BTNOK, strBtn2Title: BTNCANCEL, button1Handler: { (UIAlertAction) in
           
            print("This is Ok action")

        }, viewController: self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(false)
    }
    
    //MARK: - ACTION METHODS-

    @IBAction func actionShowNoInternetView(_ sender : UIButton)
    {
       callWebservice()
    }
    
    @IBAction func actionNext(_ sender : UIButton)
    {
       self.performSegue(withIdentifier: "screen1ToScreen2", sender: nil)
    }

    //MARK: - USER DEFINED METHODS -

    func setupNetworkView (intType : Int)
    {
        hideShowInternetConnectionView(self.view, ParentVC:self, type: intType)
    }
    
    func callWebservice()
    {
        print("Web service called from Screen 1")
        var dicparam = [String : String]()
        dicparam = ["":""]
      
        objAPIManager.callWebservice(dicparam as [String : AnyObject], requestURL: WS_GetMatches, isLoader: true, isNetworkScreen: true, pSuccessBlock: { (result : [String : Any]) in
            
            print("Success")
            
        }, pFailerBlock: { (result : [String : Any]) in
            
            print("Error")
            
        }) { (NoConType : Int) in
            
            self.setupNetworkView(intType: NoConType)
        }
    }
    
    //MARK: - MEMORY MANAGEMENT-
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

