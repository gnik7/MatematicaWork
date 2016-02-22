//
//  ServerManager.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation


class ServerManager: NSObject {
    
    var requestOperationManager: AFHTTPSessionManager!
    

    
    class var sharedInstance: ServerManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ServerManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ServerManager()
        }
        return Static.instance!
    }
    
    override init(){
        //get token from info.plist
//        var myDict: NSDictionary?
//        
//        if let path = NSBundle.mainBundle().pathForResource("Info", ofType: "plist") {
//            myDict = NSDictionary(contentsOfFile: path)
//        }
//        if let dict = myDict {
//            self.mainUrl = dict.objectForKey("api_url") as! String
//        }
        
        let url: NSURL = NSURL(string: "http://jsonplaceholder.typicode.com/")!
        self.requestOperationManager = AFHTTPSessionManager(baseURL: url)
        self.requestOperationManager.requestSerializer = AFJSONRequestSerializer()
        self.requestOperationManager.responseSerializer = AFJSONResponseSerializer()

    }
    
    
   func getAllPosts(success:(response: NSArray)->Void, failure:(errorMessage:String?) -> Void){
     
        let path : String = "posts"
        self.requestOperationManager.GET(path,
            parameters: nil,
            progress: nil,
            success: { (task:NSURLSessionDataTask , responceObject:AnyObject?) -> Void in
                
                let dictArr: NSArray = responceObject as! NSArray
                let objectsArr: NSMutableArray = NSMutableArray()
                for dict in dictArr {
                    let postModel = PostModel(responseObject: dict as! NSDictionary)
                    objectsArr.addObject(postModel)
                }
                success(response: objectsArr)
               
                
            } , failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })
    }
    
    
    func getAllUsers(success:(response: NSArray)->Void, failure:(errorMessage:String?) -> Void){
        
        let path : String = "users"
        self.requestOperationManager.GET(path,
            parameters: nil,
            progress: nil,
            success: { (task:NSURLSessionDataTask , responceObject:AnyObject?) -> Void in
                //print(responceObject)
                let dictArr: NSArray = responceObject as! NSArray
                let objectsArr: NSMutableArray = NSMutableArray()
                for dict in dictArr {
                    let postModel = UserModel(responseObject: dict as! NSDictionary)
                    objectsArr.addObject(postModel)
                }
                success(response: objectsArr)
                
                
            } , failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })
    }
    
    func getPostById(postId: NSInteger ,success:(response: NSArray)->Void, failure:(errorMessage:String?) -> Void){
        
        let path : String = "comments?"
        let postID : String = String(postId)
        
        let params = [
            "postId" : postID
        ]
        self.requestOperationManager.GET(path,
            parameters: params,
            progress: nil,
            success: { (task:NSURLSessionDataTask , responceObject:AnyObject?) -> Void in
                print(responceObject)
                let dictArr: NSArray = responceObject as! NSArray
                let objectsArr: NSMutableArray = NSMutableArray()
                for dict in dictArr {
                    let postModel = CommentModel(responseObject: dict as! NSDictionary)
                    objectsArr.addObject(postModel)
                }
                success(response: objectsArr)
                
                
            } , failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })
    }

    func getAllAlbums(success:(response: NSArray)->Void, failure:(errorMessage:String?) -> Void){
        
        let path : String = "albums"
        self.requestOperationManager.GET(path,
            parameters: nil,
            progress: nil,
            success: { (task:NSURLSessionDataTask , responceObject:AnyObject?) -> Void in
                //print(responceObject)
                let dictArr: NSArray = responceObject as! NSArray
                let objectsArr: NSMutableArray = NSMutableArray()
                for dict in dictArr {
                    let postModel = AlbomModel(responseObject: dict as! NSDictionary)
                    objectsArr.addObject(postModel)
                }
                success(response: objectsArr)
                
                
            } , failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })
    }



    
}

