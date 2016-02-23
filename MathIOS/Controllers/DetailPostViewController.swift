//
//  DetailPostViewController.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation
import UIKit

class DetailPostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var bodyTextView     : UITextView!
    @IBOutlet weak var commentTableView : UITableView!
    
    private var commentsArray :Array<CommentModel>!
    
    var postId      : NSInteger!
    var titlePost   : String!
    var bodyPost    :String!
    
    var hud                     : MBProgressHUD!
    //--------------------------------------------
    // MARK: - INIT
    //--------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentTableView.dataSource = self
        self.commentTableView.delegate = self
        
        commentsArray = Array<CommentModel>()
        
        titleLabel.text = titlePost
        bodyTextView.text = bodyPost
        
        commentTableView.tableFooterView = UIView()
        
        createProgressHUD()
        
        ServerManager.sharedInstance.getPostById(postId,
            success: { (response) -> Void in
                self.commentsArray = response as NSArray as! Array<CommentModel>
                self.commentTableView.reloadData()
                self.hideProgressHUD()

            },failure:  { (errorMessage) -> Void in
                self.hideProgressHUD()
        })
              
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--------------------------------------------
    // MARK: - UITableViewDelegate
    //--------------------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count
    }
    //--------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:DetailPostCell = tableView.dequeueReusableCellWithIdentifier("DetailPostCell", forIndexPath: indexPath) as! DetailPostCell
        
        if commentsArray.count > 0 {
            let comment = commentsArray[indexPath.row] as CommentModel
            
            cell.nameLabel.text = comment.name
            cell.emailLabel.text = comment.email
            cell.bodyTextView.text = comment.body
        }
        
        return cell
    }
    
    //--------------------------------------------
    
    //--------------------------------------------
    // MARK: - Segue
    //--------------------------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "BackToPosts" {
            let vc : PostsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
            vc.hidesBottomBarWhenPushed = true
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                self.presentViewController(vc, animated: true, completion: { () -> Void in
                    
                })
            })
        }
        
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