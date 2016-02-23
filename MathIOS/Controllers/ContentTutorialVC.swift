//
//  ContentTutorialVC.swift
//  MathIOS
//
//  Created by Nikita Gil' on 23.02.16.
//  Copyright © 2016 Nikita Gil'. All rights reserved.
//

import Foundation
import UIKit


class ContentTutorialVC: UIViewController {
    
    var dataObject: AnyObject?
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.loadHTMLString(dataObject as! String,
            baseURL: NSURL(string: ""))
    }
}