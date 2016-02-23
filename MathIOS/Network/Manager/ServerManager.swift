//
//  ServerManager.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation


class ServerManager: NSObject {
    
    var requestOperationManager : AFHTTPSessionManager!
    var hud                     : MBProgressHUD!
       
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

        let url: NSURL = NSURL(string: "http://jsonplaceholder.typicode.com/")!
        self.requestOperationManager = AFHTTPSessionManager(baseURL: url)
        self.requestOperationManager.requestSerializer = AFJSONRequestSerializer()
        self.requestOperationManager.responseSerializer = AFJSONResponseSerializer()

    }
    
    //--------------------------------------------
    // MARK: - API CALLS
    //--------------------------------------------

    
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
    
    //-------------------------------------------
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
    //-------------------------------------------
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
    //-------------------------------------------

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
    //-------------------------------------------
    
    func getAllPhotos(success:(response: NSArray)->Void, failure:(errorMessage:String?) -> Void){
       
        let path : String = "photos"
        self.requestOperationManager.GET(path,
            parameters: nil,
            progress: nil,
            success: { (task:NSURLSessionDataTask , responceObject:AnyObject?) -> Void in
                
                let dictArr: NSArray = responceObject as! NSArray
                let objectsArr: NSMutableArray = NSMutableArray()
                for dict in dictArr {
                    let postModel = PhotosModel(responseObject: dict as! NSDictionary)
                    objectsArr.addObject(postModel)
                }
                success(response: objectsArr)
                
                
            } , failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                print(error)
        })
        
    }
    
    //--------------------------------------------
    // MARK: - MESSAGE
    //--------------------------------------------
    func alertMessage(title: String, message: String ) {
        let alert = UIAlertController(title: title ,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK" , style: UIAlertActionStyle.Default, handler: nil))
        let alertWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.presentViewController(alert, animated: true, completion: nil)
    }
    
    //--------------------------------------------
    // MARK: - Progress
    //--------------------------------------------
    
    //-----------------------------------------
    func createProgressHUD(){

        hud = MBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().delegate?.window??.rootViewController?.view, animated: true)
        hud.labelText = "Loading"
    }
    //-----------------------------------------
    func hideProgressHUD(){
        let window = UIApplication.sharedApplication().delegate?.window??.rootViewController?.view
        MBProgressHUD.hideHUDForView(window, animated: true)
        self.hud = nil
    }



    
}

