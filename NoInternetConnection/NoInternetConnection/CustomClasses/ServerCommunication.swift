//
//  ServerCommunication.swift
//  NoInternetConnection
//
//  Created by Aarti Oza on 21/04/17.
//  Copyright © 2017 Aarti Oza. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SystemConfiguration
import SVProgressHUD

typealias mySuccessBlock = ([String : Any]) -> ()
typealias myFailuerBlock = ([String : Any]) -> ()
typealias myNetworkBlock = (Int) -> ()

let KCODEWIFINOTCONNECTED = 3840
let KCODENOCONNECTION = -1009

class ServerCommunication: NSObject
{
    private var alamoFireManager = Alamofire.SessionManager()

    static var sharedInstance: ServerCommunication = {
        return ServerCommunication()
    }()
    
    private override init() {
    }
    
    func cancelAllRequests()
    {
        print("cancelling NetworkHelper requests")
        alamoFireManager.session.invalidateAndCancel()
        setAFconfig()
    }
    
    func setAFconfig()
    {
        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForResource = 4
//        configuration.timeoutIntervalForRequest = 4
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func isConnectedToNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func showLoader(isShow : Bool)
    {
        if isShow
        {
            SVProgressHUD.show(withStatus: "Loading...")
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        }
    }
    
    func hideLoader(isShow : Bool)
    {
        if isShow
        {
            SVProgressHUD.dismiss()
        }
    }
    
    func callWebservice(_ dictParam:[String:Any]?,requestURL:String, isLoader : Bool, isNetworkScreen : Bool, pSuccessBlock:@escaping mySuccessBlock,pFailerBlock:@escaping myFailuerBlock, pNetworkBlock:myNetworkBlock?)
    {
        showLoader(isShow : isLoader)
        
        if isConnectedToNetwork() == true
        {
            let url = kBaseURL + requestURL
            print("URL == >\(url)")
            print("Parameter ===>\(dictParam)")
            
            Alamofire.request(url, method: .put, parameters: dictParam, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json"])
                .responseJSON { response in
                    
                print("response ===== \(response)")
                
                do {
                    print("Web service Response")
                    let objJson = try JSONSerialization.jsonObject(with: response.data!, options: [])
                    
                    if let status = objJson as? [String : Any]
                    {
                        //let strCode = status["code"]! as? String ?? ""
                        if let strCode = status["code"]
                        {
                            self.hideLoader(isShow : isLoader)

                            if strCode as! Int == 1
                            {
                                pSuccessBlock(objJson as! [String : Any])
                                print(objJson)
                            }
                            else
                            {
                                pFailerBlock(objJson as! [String : Any])
                                SVProgressHUD.dismiss()
                            }
                        }
                        else
                        {
                            self.hideLoader(isShow : isLoader)

                            //In case of internal server error code will be nil
                            if isNetworkScreen
                            {
                               pNetworkBlock!(typeForNoConnection.somethingWentWrong.rawValue)
                            }
                            else
                            {
                                print(SOMETHINGWENTWRONG)
                            }
                        }
                    }
                    else
                    {
                        self.hideLoader(isShow : isLoader)

                        if isNetworkScreen
                        {
                             pNetworkBlock!(typeForNoConnection.notResponding.rawValue)
                        }
                        else
                        {
                            print(NOTRESPONDING)
                        }
                    }
                }
                catch let error as Error
                {
                    print(error._code)

                    /*
                    let intCode = error._code
                    
                    if intCode == KCODENOCONNECTION
                    {
                        print("No netwrok availlable.")
                    }
                    else if intCode == KCODEWIFINOTCONNECTED
                    {
                        print("Not connected to wifi.")
                    }
                    else
                    {
                        print("Request time out.")
                    }
                    */
                    
                    self.hideLoader(isShow : isLoader)

                    if isNetworkScreen
                    {
                         pNetworkBlock!(typeForNoConnection.requestTimeOut.rawValue)
                    }
                    else
                    {
                        print(REQUESTTIMEOUT)
                    }
                }
            }
        }
        else //not connected to netwrok
        {
            self.hideLoader(isShow : isLoader)

            if isNetworkScreen
            {
                 pNetworkBlock!(typeForNoConnection.noConnection.rawValue)
            }
            else
            {
                print(NOCONNECTION)
            }
            cancelAllRequests()
        }
    }
}
