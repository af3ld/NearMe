//
//  YelpHelper.swift
//  NearMe
//
//  Created by Alex Feldman on 10/7/15.
//  Copyright © 2015 Alex Feldman. All rights reserved.
//

import Foundation
import AFNetworking
import OAuthSwift
import BDBOAuth1Manager

class APIHelper: BDBOAuth1RequestOperationManager {
    
    var token: String!
    var token_secret: String!
    var api_key: String!
    var api_secret: String!
    
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.token = accessToken
        self.token_secret = accessSecret
        let baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        let access = BDBOAuth1Credential(token: token, secret: token_secret, expiration: nil)
        self.requestSerializer.saveAccessToken(access)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}








