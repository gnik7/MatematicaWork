//
//  AlbomModel.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation

class AlbomModel:NSObject {
    
    var userID      : NSNumber!
    var albomID     : NSNumber!
    var title       : String!

   
    override init(){
        
    }
    
    init(responseObject: NSDictionary!) {
        
        self.albomID = responseObject.objectForKey("id") as? NSNumber
        self.userID = responseObject.objectForKey("userId") as? NSNumber
        self.title = responseObject.objectForKey("title") as? String
        
    }
    
}
