//
//  TutorialViewController.swift
//  MathIOS
//
//  Created by Nikita Gil' on 23.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation
import UIKit

class TutorialViewController: UIViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate  {
    
    var pageViewController: UIPageViewController?
    var pageContent = NSArray()
    var contentString = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if userDefaults.objectForKey("TutorialCount") == nil {
            
            let counter: Int = 1
            
            userDefaults.setObject(counter, forKey: "TutorialCount")
            userDefaults.synchronize()
            
            createContentPages()
            createPageViewController()
            setupPageControl()
            
        } else {
            var counter : Int = userDefaults.objectForKey("TutorialCount") as! Int
            if counter < 4 {
                counter++
                userDefaults.setObject(counter, forKey: "TutorialCount")
                
                userDefaults.synchronize()
                createContentPages()
                createPageViewController()
                setupPageControl()
                
            }
        }        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLoad()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if userDefaults.objectForKey("TutorialCount") != nil {
            let counter : Int = userDefaults.objectForKey("TutorialCount") as! Int
            if counter == 4 {

                let tab = self.storyboard?.instantiateViewControllerWithIdentifier("TabContrl") as! UITabBarController
                self.view.window!.rootViewController = tab
                let  window = UIWindow(frame: UIScreen.mainScreen().bounds)
                window.makeKeyAndVisible()


            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if pageContent.count > 0 {
            let firstController = viewControllerAtIndex(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    
    func createContentPages() {
        
        var pageStrings = [String]()
        let contentString1 = "<html><head></head><body><br><h1>Tutorial</h1><h2>POST</h2><p>This is the page will containe description about post</p></body></html>"
        let contentString2 = "<html><head></head><body><br><h1>Tutorial</h1><h2>Albums</h2><p>This is the page will containe description about albums</p></body></html>"
        let contentString3 = "<html><head></head><body><br><h1>Tutorial</h1><h2>Comments</h2><p>This is the page will containe description about comments</p></body></html>"
        
        pageStrings.append(contentString1)
        pageStrings.append(contentString2)
        pageStrings.append(contentString3)
        
        pageContent = pageStrings
    }
    
    func viewControllerAtIndex(index: Int) -> ContentTutorialVC? {
        
        if (pageContent.count == 0) ||
            (index >= pageContent.count) {
                return nil
        }
        
        let storyBoard = UIStoryboard(name: "Main",
            bundle: NSBundle.mainBundle())
        let dataViewController = storyBoard.instantiateViewControllerWithIdentifier("contentView") as! ContentTutorialVC
        
        dataViewController.dataObject = pageContent[index]
        return dataViewController
    }
    
    func indexOfViewController(viewController: ContentTutorialVC) -> Int {
        
        if let dataObject: AnyObject = viewController.dataObject {
            return pageContent.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController
            as! ContentTutorialVC)
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController
            as! ContentTutorialVC)
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index < pageContent.count {
            return viewControllerAtIndex(index)
        } else if index == pageContent.count {
            
            let tab = self.storyboard?.instantiateViewControllerWithIdentifier("TabContrl") as! UITabBarController
            self.view.window!.rootViewController = tab
            let  window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window.makeKeyAndVisible()

            /*
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let vc : PostsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PostsViewController") as! PostsViewController
                self.pageViewController!.view.removeFromSuperview()
                self.pageViewController?.removeFromParentViewController()
                self.presentViewController(vc, animated: true, completion: { () -> Void in
                    
                })
            })*/
           
        }
        return nil
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageContent.count + 1
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int{
        return  0
    }

    
    
    
}

