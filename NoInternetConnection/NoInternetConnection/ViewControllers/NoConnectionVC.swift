//
//  NoConnectionVC.swift
//  NoInternetConnection
//
//  Created by Aarti Oza on 21/04/17.
//  Copyright © 2017 Aarti Oza. All rights reserved.
//

import UIKit

class NoConnectionVC: UIViewController
{
    //MARK: - OUTLET/VARIABLE -

    @IBOutlet var imgForConnection : UIImageView!
    @IBOutlet var lblMessage : UILabel!

    var intViewType = Int()
    var strLblMsg = ""
    
    //MARK: - VIEW LIFE CYCLE -

    override func viewDidLoad()
    {
        super.viewDidLoad()
        initialSetup()
        //Do any additional setup after loading the view.
    }
    
    //MARK: - CUSTOM METHODS -

    func initialSetup()
    {
        switch intViewType
        {
            case typeForNoConnection.noConnection.rawValue:
                imgForConnection.image = UIImage(named: strImgName)
                lblMessage.text = strLblMsg == STREMPTY ? NOCONNECTION : strLblMsg
                break
                
            case typeForNoConnection.notResponding.rawValue:
                imgForConnection.image = UIImage(named: strImgName)
                lblMessage.text = strLblMsg == STREMPTY ? NOTRESPONDING : strLblMsg
                break
            
            case typeForNoConnection.somethingWentWrong.rawValue:
                imgForConnection.image = UIImage(named: strImgName)
                lblMessage.text = strLblMsg == STREMPTY ? SOMETHINGWENTWRONG : strLblMsg
                break
                
            case typeForNoConnection.requestTimeOut.rawValue:
                imgForConnection.image = UIImage(named: strImgName)
                lblMessage.text = strLblMsg == STREMPTY ? REQUESTTIMEOUT :strLblMsg
                break
                
            case typeForNoConnection.defaultType.rawValue:
                imgForConnection.image = UIImage(named: strImgName)
                lblMessage.text = strLblMsg
                break
                
            default:
                break
        }
    }
    
    //MARK: - ACTION METHODS -

    @IBAction func actionRemoveChildView(_ sender : UIButton)
    {
        let parentVC : UIViewController = self.parent!
        
        switch parentVC
        {
            case is Screen1VC:
                let tempVC = self.parent as! Screen1VC
                tempVC.callWebservice()
                break
            
            case is Screen2VC:
                let tempVC = self.parent as! Screen1VC
                tempVC.callWebservice()
                break
            
            default:
                break
        }
        
        if parentVC.isKind(of: Screen1VC.self)
        {
            let tempVC = self.parent as! Screen1VC
            tempVC.callWebservice()
        }
        else if parentVC.isKind(of: Screen2VC.self)
        {
            let tempVC = self.parent as! Screen2VC
            tempVC.callWebservice()
        }
        // and so on
        
        self.view.isHidden = true
        self.removeFromParentViewController()
    }
    
    //MARK: - MEMORY MANAGEMENT -
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
