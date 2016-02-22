//
//  AlbomUsersViewController.swift
//  MathIOS
//
//  Created by Nikita Gil' on 21.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation
import UIKit

class AlbomUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchUsers: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    
    var usersArray : Array<UserModel>!
    var albomsArray : Array<AlbomModel>!
    var containerArray : Array<Int>!
    
    //--------------------------------------------
    // MARK: - INIT
    //--------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usersTableView.dataSource = self
        self.usersTableView.delegate = self
        
        usersArray = Array<UserModel>()
        albomsArray = Array<AlbomModel>()
        containerArray = Array<Int>()
        
        
        ServerManager.sharedInstance.getAllAlbums({ (response) -> Void in
            
            self.albomsArray = response as NSArray as! Array<AlbomModel>
            
            ServerManager.sharedInstance.getAllUsers({ (response) -> Void in
                
                self.usersArray = response as NSArray as! Array<UserModel>
                
                for al in self.albomsArray {
                    let album = al
                    for user in self.usersArray {
                        let us = user
                        if album.userID.integerValue == us.userID.integerValue {
                            if self.containerArray.count == 0 {
                                self.containerArray.append(us.userID.integerValue)
                            } else {
                                if !self.containerArray.contains(us.userID.integerValue) {
                                    self.containerArray.append(us.userID.integerValue)
                                }
                            }
                        }
                    }
                    
                }
                
                self.usersTableView.reloadData()
                }, failure: { (errorMessage) -> Void in
                    
            })
            
            },failure:  { (errorMessage) -> Void in
                
        })
        
        usersTableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--------------------------------------------
    // MARK: - UITableViewDelegate
    //--------------------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return containerArray.count
    }
    //--------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if containerArray.count > 0 {
            for user in usersArray {
                if containerArray[indexPath.row] == user.userID.integerValue {
                    cell.textLabel?.text = user.name
                    cell.tag = user.userID.integerValue
                }
            }
        }
        
        return cell
    }
    
    //--------------------------------------------
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let postM = postsArray[indexPath.row] as PostModel
//        
//        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("DetailPostViewController") as! DetailPostViewController
//        vc.postId = postM.postID.integerValue
//        vc.titlePost = postM.title
//        vc.bodyPost = postM.body
//        
//        self.presentViewController(vc, animated: true, completion: nil)
    }
    //--------------------------------------------

    //--------------------------------------------
    // MARK: - UISearchBarDelegate
    //--------------------------------------------
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchUsers.text = ""
        return true
    }
    //--------------------------------------------
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchUsers.showsCancelButton = true
    }
    //--------------------------------------------
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchUsers.resignFirstResponder()
        searchUsers.showsCancelButton = false
    }
    
    //--------------------------------------------
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    //--------------------------------------------
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchUsers.resignFirstResponder()
        searchUsers.showsCancelButton = false
    }
    //--------------------------------------------
    
}


/*
optional public func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool // return NO to not become first responder
@available(iOS 2.0, *)
optional public func searchBarTextDidBeginEditing(searchBar: UISearchBar) // called when text starts editing
@available(iOS 2.0, *)
optional public func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool // return NO to not resign first responder
@available(iOS 2.0, *)
optional public func searchBarTextDidEndEditing(searchBar: UISearchBar) // called when text ends editing
@available(iOS 2.0, *)
optional public func searchBar(searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
@available(iOS 3.0, *)
optional public func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool // called before text changes

@available(iOS 2.0, *)
optional public func searchBarSearchButtonClicked(searchBar: UISearchBar) // called when keyboard search button pressed
@available(iOS 2.0, *)
optional public func searchBarBookmarkButtonClicked(searchBar: UISearchBar) // called when bookmark button pressed
@available(iOS 2.0, *)
optional public func searchBarCancelButtonClicked(searchBar: UISearchBar) // called when cancel button pressed
@available(iOS 3.2, *)
optional public func searchBarResultsListButtonClicked(searchBar: UISearchBar) // called when search results button pressed

@available(iOS 3.0, *)
optional public func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)




*/
    