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
    
    var usersArray      : Array<UserModel>!
    var albomsArray     : Array<AlbomModel>!
    var containerArray  : Array<Int>!
    var tmpArray        : Array<Int>!
    
    var hud             : MBProgressHUD!
    
    //--------------------------------------------
    // MARK: - INIT
    //--------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usersTableView.dataSource = self
        self.usersTableView.delegate = self
        self.searchUsers.delegate = self
        
        usersArray = Array<UserModel>()
        albomsArray = Array<AlbomModel>()
        containerArray = Array<Int>()
        tmpArray = Array<Int>()
        
        createProgressHUD()
        
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
                
                self.tmpArray = self.containerArray
                
                self.usersTableView.reloadData()
                self.hideProgressHUD()
                }, failure: { (errorMessage) -> Void in
                    self.hideProgressHUD()
            })
            
            },failure:  { (errorMessage) -> Void in
                self.hideProgressHUD()
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
        return tmpArray.count
    }
    //--------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if tmpArray.count > 0 {
            for user in usersArray {
                if tmpArray[indexPath.row] == user.userID.integerValue {
                    cell.textLabel?.text = user.name
                    cell.tag = user.userID.integerValue
                }
            }
        }
        
        return cell
    }
    
    //--------------------------------------------
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let userId = tmpArray[indexPath.row]
        
        var albumsUserArray = Array<Int>()
        
        for album in self.albomsArray {
            if album.userID.integerValue == userId {
                albumsUserArray.append(album.albomID.integerValue)
            }
        }
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("AlbumPhotoCollection") as! AlbumPhotoCollection
        vc.albumsIDArray = albumsUserArray
        self.presentViewController(vc, animated: true, completion: nil)
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
        searchUsers.text = ""
        self.tmpArray = self.containerArray
        self.usersTableView.reloadData()
    }
    
    //--------------------------------------------
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.tmpArray = Array<Int>()
        for user in self.usersArray {
            if (user.name.lowercaseString).hasPrefix(searchText.lowercaseString) {
                self.tmpArray.append(user.userID.integerValue)
                print(user.name.lowercaseString)
            }
        }
        self.usersTableView.reloadData()
    }
    
    //--------------------------------------------
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchUsers.resignFirstResponder()
        searchUsers.showsCancelButton = false
        searchUsers.text = ""
        self.tmpArray = self.containerArray
        self.usersTableView.reloadData()
    }
    //--------------------------------------------
    
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


    