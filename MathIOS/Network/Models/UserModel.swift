//
//  UserModel.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation

class UserModel:NSObject {
    
    var userID  : NSNumber!
    var email   :String!
    var name    :String!
    var username    :String!
    
    
    
    override init(){
        
    }
    
    init(responseObject: NSDictionary!) {
        
        self.userID = responseObject.objectForKey("id") as? NSNumber
        self.email = responseObject.objectForKey("email") as? String
        self.name = responseObject.objectForKey("name") as? String
        self.name = responseObject.objectForKey("username") as? String
    }
    
}
