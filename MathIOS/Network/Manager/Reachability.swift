//
//  Reachability.swift
//  MathIOS
//
//  Created by comp23 on 2/23/16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation

public class Reachability {
    
    class func isConnectedToNetwork()->Bool{
        
        var Status:Bool = false
        let url = NSURL(string: "https://www.dropbox.com")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        
        var response: NSURLResponse?
        do{
            try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        }
        catch{
            fatalError("Error loading URL ")
        }
        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        
        return Status
    }
}