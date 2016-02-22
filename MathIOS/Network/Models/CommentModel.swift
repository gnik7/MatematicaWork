//
//  CommentModel.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation

class CommentModel:NSObject {
    
    var postID      : NSNumber!
    var commentID   : NSNumber!
    var email       :String!
    var name        :String!
    var body        :String!
    
    
    
    override init(){
        
    }
    
    init(responseObject: NSDictionary!) {
        
        self.postID = responseObject.objectForKey("postId") as? NSNumber
        self.commentID = responseObject.objectForKey("Id") as? NSNumber
        self.email = responseObject.objectForKey("email") as? String
        self.name = responseObject.objectForKey("name") as? String
        self.body = responseObject.objectForKey("body") as? String
    }
    
}
