//
//  YelpHelper.swift
//  NearMe
//
//  Created by Alex Feldman on 10/7/15.
//  Copyright © 2015 Alex Feldman. All rights reserved.
//

import Foundation
import OAuthSwift

struct YelpHelperConsole {
    let yelp_api_key:String = "YHLpRxukJnjKlqSovUJ1Qw"
    let yelp_api_secret:String = "W3vGmYPT6jc0N5lShpw0OSzeGQk"
    let yelp_api_token:String = "WW1PJiUP9RagnvJiS4IYHlCjjXfy-HS3"
    let yelp_api_token_secret:String = "7OfmO9imvtbgr0hfq-CcQPR7cLw"
}

class YelpHelper: NSObject {
    
    let APIBaseUrl = "http://api.yelp.com/v2/"
    let clientOAuth: OAuthSwiftClient?
    let apiConsoleInfo: YelpHelperConsole
    
    override init() {
        apiConsoleInfo = YelpHelperConsole()
        self.clientOAuth = OAuthSwiftClient(consumerKey: apiConsoleInfo.yelp_api_key, consumerSecret: apiConsoleInfo.yelp_api_secret, accessToken: apiConsoleInfo.yelp_api_token, accessTokenSecret: apiConsoleInfo.yelp_api_token_secret)
        super.init()
    }
    
}



