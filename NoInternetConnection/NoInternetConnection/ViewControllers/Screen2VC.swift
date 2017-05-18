//
//  Screen2VC.swift
//  NoInternetConnection
//
//  Created by Aarti Oza on 21/04/17.
//  Copyright © 2017 Aarti Oza. All rights reserved.
//

import UIKit

class Screen2VC: BaseViewController
{
    //MARK: - VIEW LIFE CYCLE -

    override func viewDidLoad()
    {
        super.viewDidLoad()
        showAlertWithTwoButtonTitle(strTitle: APPNAME, strMessage: "Webservice call screen without no connection screen.", strBtn1Title: BTNOK, strBtn2Title: BTNCANCEL, button1Handler: nil, viewController: self)
        // Do any additional setup after loading the view.
    }

    //MARK: - ACTION METHODS -

    @IBAction func actionShow(_ sender : UIButton)
    {
        callWebservice()
    }
    
    @IBAction func actionBack(_ sender : UIButton)
    {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - USER DEFINED METHODS -
    
    func callWebservice()
    {
        print("Web service called from Screen 2")
        
        var dicparam = [String : String]()
        dicparam = ["":""]

        objAPIManager.callWebservice(dicparam, requestURL: WS_GetMatches, isLoader: true, isNetworkScreen: false, pSuccessBlock: { (result : [String : Any]) in
            
            print("Success")
            
        }, pFailerBlock: { (result : [String : Any]) in
            
            print("Error")

        }, pNetworkBlock: nil)
    }
    
    //MARK: - MEMORY MANAGEMENT5 -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
