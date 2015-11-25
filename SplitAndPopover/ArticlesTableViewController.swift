//
//  ArticlesTableViewController.swift
//  Phone Media
//
//  Created by Mau Pan on 11/9/15.
//  Copyright © 2015 Mau Pan. All rights reserved.
//

import UIKit
import Foundation

class ArticlesTableViewController: UITableViewController, XMLParserDelegate {
    
    
    @IBAction func newsTab(sender: AnyObject) {
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversitynews")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
        navigationController?.navigationBar.topItem!.title = "New University » News"
    }
    
    @IBAction func aeTab(sender: AnyObject) {
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversityAE")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
        navigationController?.navigationBar.topItem!.title = "New University » A & E"
        
    }
    
    @IBAction func featuresTab(sender: AnyObject) {
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversityfeatures")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
        navigationController?.navigationBar.topItem!.title = "New University » Features"
    }
    
    @IBAction func sportsTab(sender: AnyObject) {
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversitysports")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
        navigationController?.navigationBar.topItem!.title = "New University » Sports"
    }
    
    @IBAction func opinionTab(sender: AnyObject) {
        currentCategory = "opinion"
        navigationController?.navigationBar.topItem!.title = "New University » Opinion"
    }
    
    var titles = [String]()
    var descriptions = [String]()
    
    var currentCategory = "news"
    
    var xmlParser : XMLParser!
    
    func parsingWasFinished() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure back button when viewing an article
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back to Articles", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversitynews")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return xmlParser.arrParsedData.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! cell
        let currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        
        var htmlContent = ""
        let blankImage = "https://s0.wp.com/i/blank.jpg"
        
        myCell.cellTitle.text = currentDictionary["title"]
        if (Int(currentDictionary["pubDate"]!)! >  1) {
            myCell.cellPubDate.text = currentDictionary["pubDate"]! + "d ago"
        } else if (Int(currentDictionary["pubDate"]!)! == 1) {
            myCell.cellPubDate.text = "Yesterday"
        } else {
            myCell.cellPubDate.text = "Today"
        }
        // Configure the cell...
        
        // Get first image from article and insert in cell image
        /*
        let url = NSURL(string: "https://readability.com/api/content/v1/parser?url=" + currentDictionary["link"]! + "&token=feb9f63784ab762c652c9bf50579b8422b2bd049")!

        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                do {
                    var imageURL = ""
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    if jsonResult["lead_image_url"] != nil {
                        imageURL = jsonResult["lead_image_url"] as! String
                    }
                    if (imageURL.lowercaseString.rangeOfString("http://www.newuniversity.org/wp-content/uploads/") != nil ) {
                        print(imageURL)
                        let url = NSURL(string: imageURL)
                        let imageData = NSData(contentsOfURL: url!)
                        myCell.cellImage.image = UIImage(data: imageData!)
                    }
                    
                    
                } catch{
                    print("JSON serialization error")
                }
                
                
            } else {
                
                print("Retrieval failed")
                
            }
            
        }
        
        task.resume()

*/
        //print(htmlContent)
        /*
        if imageSource != blankImage {
            myCell.cellImage.set
        }
        */
        return myCell
    }
    
    /*
    func firstMatchIn(string: NSString!, atRangeIndex: Int!) -> String {
        var error : NSError?
        let re = NSRegularExpression(pattern: self, options: .CaseInsensitive)
        let match = re.firstMatchInString(string, options: .WithoutAnchoringBounds, range: NSMakeRange(0, string.length))
        return string.substringWithRange(match.rangeAtIndex(atRangeIndex))
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentDictionary = xmlParser.arrParsedData[indexPath.row] as Dictionary<String, String>
        let articleLink = "https://readability.com/m?url=" + currentDictionary["link"]!
        let articleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("idArticleViewController") as! ArticleViewController
        
        articleViewController.articleURL = NSURL(string: articleLink)
        
        showDetailViewController(articleViewController, sender: self)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
