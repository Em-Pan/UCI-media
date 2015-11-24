//
//  ArticlesTableViewController.swift
//  Phone Media
//
//  Created by Mau Pan on 11/9/15.
//  Copyright © 2015 Mau Pan. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController, XMLParserDelegate {
    
    
    @IBAction func newsTab(sender: AnyObject) {
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversitynews")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
    }
    
    @IBAction func aeTab(sender: AnyObject) {
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversityAE")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
        
    }
    
    @IBAction func featuresTab(sender: AnyObject) {
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversityfeatures")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
    }
    
    @IBAction func sportsTab(sender: AnyObject) {
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversitysports")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
    }
    
    @IBAction func opinionTab(sender: AnyObject) {
        currentCategory = "opinion"
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
        
        let url = NSURL(string: "https://feeds.feedburner.com/newuniversitynews")!
        xmlParser = XMLParser()
        xmlParser.delegate = self
        xmlParser.startParsingWithContentsOfURL(url)
        /*
        for i in xmlParser.arrParsedData {
        print(i)
        }*/
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
        myCell.cellPubDate.text = currentDictionary["pubDate"]! + "d ago"
        // Configure the cell...
        
        // Get first image from article and insert in cell image
        /*
        let url = NSURL(string: currentDictionary["link"]!)
        do {
            htmlContent = try NSString(contentsOfURL: url!, encoding: NSUTF8StringEncoding) as String
        } catch {
            print("error")
        }
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
        let articleLink = "http://www.readability.com/m?url=" + currentDictionary["link"]!
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
