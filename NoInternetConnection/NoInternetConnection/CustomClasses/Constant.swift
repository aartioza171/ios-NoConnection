//
//  Constant.swift
//  NoInternetConnection
//
//  Created by Aarti Oza on 21/04/17.
//  Copyright © 2017 Aarti Oza. All rights reserved.
//

import Foundation

//MARK: - VARIABLE DECLARATION -

let objAPIManager : ServerCommunication = ServerCommunication.sharedInstance

let APPNAME = "No Connection"

let kBaseURL = "https://api.foursquare.com/v2/venues/suggestCompletion?ll=23.041261,72.513892&query=hone&oauth_token=4WFFQGIBK50PB4BEQHJADZWDLZQSF0Z2ZYV5HBIXSVWEQVSS&v=20161121"
let WS_GetMatches = ""
let strImgName = "NoConnection.png"
let STREMPTY = ""

let BTNOK = "Ok"
let BTNCANCEL = "Cancel"

//MARK: - ENUM -

enum typeForNoConnection : Int
{
    case noConnection = 101,
    notResponding,
    somethingWentWrong,
    requestTimeOut,
    defaultType
}
