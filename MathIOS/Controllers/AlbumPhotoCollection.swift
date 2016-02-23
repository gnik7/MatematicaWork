//
//  AlbumPhotoCollection.swift
//  MathIOS
//
//  Created by Nikita Gil' on 22.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation
import UIKit


class AlbumPhotoCollection: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
 
    @IBOutlet var photoCollection: UICollectionView!
    
    var hud                     : MBProgressHUD!
    
    private var imageUrlArray   : Array<String>!
    private var photosArray     : Array<PhotosModel>!
    
    var albumsIDArray           : Array<Int>!
    
    //--------------------------------------------
    // MARK: - INIT
    //--------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageUrlArray = Array<String>()
        self.photosArray = Array<PhotosModel>()
        
        self.photoCollection.delegate = self
        self.photoCollection.dataSource = self
        
        
        navigationController?.navigationBarHidden = false
        
        createProgressHUD()
        
        ServerManager.sharedInstance.getAllPhotos({ (response) -> Void in
            
            self.photosArray = response as NSArray as! Array<PhotosModel>
            for ph in self.photosArray {
                if  self.albumsIDArray.contains(ph.albumId.integerValue) {
                    self.imageUrlArray.append(ph.thumbnailUrl)
                }
            }
            
            self.photoCollection.reloadData()

            self.hideProgressHUD()
            
            },failure:  { (errorMessage) -> Void in
                self.hideProgressHUD()
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return navigationController?.navigationBarHidden == false
    }
    

    //--------------------------------------------
    // MARK: - UICollectionViewDataSource
    //--------------------------------------------
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageUrlArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell:AlbumPhotoCell = collectionView.dequeueReusableCellWithReuseIdentifier("AlbumPhotoCell", forIndexPath: indexPath) as! AlbumPhotoCell
        
        if self.imageUrlArray.count > 0 {
            cell.albumImage.setImageWithURL(NSURL(string:self.imageUrlArray[indexPath.row])!, placeholderImage: UIImage(named:"placeholder"))
        }
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    

    //--------------------------------------------
    // MARK: - UICollectionViewDelegateFlowLayout
    //--------------------------------------------

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.view.frame.size.width * 0.45, self.view.frame.size.width * 0.45)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(4, 4, 4, 4)
    }
    
    //--------------------------------------------
    // MARK: - Segue
    //--------------------------------------------
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "BackToAlbums" {
            let vc : AlbomUsersViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AlbomUsersViewController") as! AlbomUsersViewController
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



