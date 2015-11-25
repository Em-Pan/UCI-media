//
//  ArticleViewController.swift
//  Phone Media
//
//  Created by Mau Pan on 11/22/15.
//  Copyright © 2015 Mau Pan. All rights reserved.
//


import UIKit

class ArticleViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var webview: UIWebView!
    
    @IBOutlet weak var pubDateButtonItem: UIBarButtonItem!
    
    
    var articleURL : NSURL!
    
    var publishDate : String!
    
    var tutorialsButtonItem : UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webview.hidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "fasfaf", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        tutorialsButtonItem = UIBarButtonItem(title: "Tutorials", style: UIBarButtonItemStyle.Plain, target: self, action: "showTutorialsViewController")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("handleFirstViewControllerDisplayModeChangeWithNotification:"), name: "PrimaryVCDisplayModeChangeNotification", object: nil)
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if articleURL != nil {
            let request : NSURLRequest = NSURLRequest(URL: articleURL)
            webview.loadRequest(request)
            
            if webview.hidden {
                webview.hidden = false
            }
            
        

        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    
    func showTutorialsViewController(){
        splitViewController?.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    }
    
    
    func handleFirstViewControllerDisplayModeChangeWithNotification(notification: NSNotification){
        let displayModeObject = notification.object as? NSNumber
        let nextDisplayMode = displayModeObject?.integerValue
        

    }
 
    

    
    
    
    @IBAction func showPublishDate(sender: AnyObject) {
        let popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idPopoverViewController") as? PopoverViewController
        
        popoverViewController?.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        popoverViewController?.popoverPresentationController?.delegate = self
        
        self.presentViewController(popoverViewController!, animated: true, completion: nil)
        
        popoverViewController?.popoverPresentationController?.barButtonItem = pubDateButtonItem
        popoverViewController?.popoverPresentationController?.permittedArrowDirections = .Any
        popoverViewController?.preferredContentSize = CGSizeMake(200.0, 80.0)
        
        popoverViewController?.lblMessage.text = "Publish Date:\n\(publishDate)"
        
    }
    
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
}
