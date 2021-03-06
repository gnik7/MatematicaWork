//
//  PostsViewController.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation
import UIKit

class PostsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var postsArray : Array<PostModel>!
    var usersArray : Array<UserModel>!
    
    @IBOutlet weak var postTableView: UITableView!
    
    
    
    
    //--------------------------------------------
    // MARK: - INIT
    //--------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postTableView.dataSource = self
        self.postTableView.delegate = self
        
        postsArray = Array<PostModel>()
       if Reachability.isConnectedToNetwork() == true {
        
        ServerManager.sharedInstance.createProgressHUD()
        
        ServerManager.sharedInstance.getAllPosts({ (response) -> Void in
            
            self.postsArray = response as NSArray as! Array<PostModel>
            
            ServerManager.sharedInstance.getAllUsers({ (response) -> Void in
                
                self.usersArray = response as NSArray as! Array<UserModel>
                self.postTableView.reloadData()
                ServerManager.sharedInstance.hideProgressHUD()
                }, failure: { (errorMessage) -> Void in
                 ServerManager.sharedInstance.hideProgressHUD()
            })            
            
            },failure:  { (errorMessage) -> Void in
              ServerManager.sharedInstance.hideProgressHUD()
        })
        
    } else {
    
       ServerManager.sharedInstance.alertMessage("Info", message:"Internet connection faild")
    }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--------------------------------------------
    // MARK: - UITableViewDelegate
    //--------------------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    //--------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:PostCell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        
        if postsArray.count > 0 {
            let postM = postsArray[indexPath.row] as PostModel
            
            cell.titlePostLabel.text = postM.title
            for user in usersArray {
                if postM.userID.integerValue == user.userID.integerValue {
                    cell.userPostLabel.text = user.name
                }
            }
        }
        
        return cell
    }

    //--------------------------------------------
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let postM = postsArray[indexPath.row] as PostModel
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailPostViewController") as! DetailPostViewController
        vc.postId = postM.postID.integerValue
        vc.titlePost = postM.title
        vc.bodyPost = postM.body
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    //--------------------------------------------
    
      
   

}


