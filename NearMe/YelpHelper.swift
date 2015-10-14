//
//  YelpHelper.swift
//  NearMe
//
//  Created by Alex Feldman on 10/7/15.
//  Copyright © 2015 Alex Feldman. All rights reserved.
//

import Foundation
import OAuthSwift

//
//
//struct YelpHelperConsole {
//    let yelp_api_key:String = "YHLpRxukJnjKlqSovUJ1Qw"
//    let yelp_api_secret:String = "W3vGmYPT6jc0N5lShpw0OSzeGQk"
//    let yelp_api_token:String = "WW1PJiUP9RagnvJiS4IYHlCjjXfy-HS3"
//    let yelp_api_token_secret:String = "7OfmO9imvtbgr0hfq-CcQPR7cLw"
//}
//
//class YelpHelper: NSObject {
////
//    let APIBaseUrl = "http://api.yelp.com/v2/"
//    let clientOAuth: OAuthSwiftClient?
//    let apiConsoleInfo: YelpHelperConsole
//    
//    override init() {
//        apiConsoleInfo = YelpHelperConsole()
//        self.clientOAuth = OAuthSwiftClient(consumerKey: apiConsoleInfo.yelp_api_key, consumerSecret: apiConsoleInfo.yelp_api_secret, accessToken: apiConsoleInfo.yelp_api_token, accessTokenSecret: apiConsoleInfo.yelp_api_token_secret)
//        super.init()
//    }
//    
//    
import Alamofire
import OAuthSwift

class YelpHelper {
    
    var token: String!
    var token_secret: String!
    var api_key: String!
    var api_secret: String!
    
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.token = accessToken
        self.token_secret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var access = BDBOAuthToken(token: token, secret: token_secret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    


}








