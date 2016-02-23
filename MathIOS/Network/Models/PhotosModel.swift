//
//  PhotosModel.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation

class PhotosModel:NSObject {
    
    var albumId             : NSNumber!
    var photoID             : NSNumber!
    var title               : String!
    var thumbnailUrl        : String!
    
    
    override init(){
        
    }
    
    init(responseObject: NSDictionary!) {
        
        self.albumId = responseObject.objectForKey("albumId") as? NSNumber
        self.photoID = responseObject.objectForKey("id") as? NSNumber
        self.title = responseObject.objectForKey("title") as? String
        self.thumbnailUrl = responseObject.objectForKey("thumbnailUrl") as? String
        
    }
    
}