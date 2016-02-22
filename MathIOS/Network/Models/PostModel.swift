//
//  PostModel.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation

class PostModel:NSObject {
    
    var userID  : NSNumber!
    var postID  : NSNumber!
    var title   :String!
    var body    :String!
    
    override init(){

    }
    
    init(responseObject: NSDictionary!) {
        self.userID = responseObject.objectForKey("userId") as? NSNumber
        self.postID = responseObject.objectForKey("id") as? NSNumber
        self.title = responseObject.objectForKey("title") as? String
        self.body = responseObject.objectForKey("body") as? String
    }
    
}
