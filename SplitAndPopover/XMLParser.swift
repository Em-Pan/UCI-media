//
//  XMLParser.swift
//  Phone Media
//
//  Created by Mau Pan on 11/9/15.
//  Copyright © 2015 Mau Pan. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate{
    func parsingWasFinished()
}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var arrParsedData = [Dictionary<String, String>]()
    
    var currentDataDictionary = Dictionary<String, String>()
    
    var currentElement = ""
    
    var foundCharacters = ""
    
    var delegate : XMLParserDelegate?
    
    func startParsingWithContentsOfURL(rssURL: NSURL) {
        
        let parser = NSXMLParser(contentsOfURL: rssURL)
        parser!.delegate = self
        parser!.parse()
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [String : String]) {
        
        currentElement = elementName
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String!) {
        if (currentElement == "title" && currentElement != "New University &#187; News") || currentElement == "description" || currentElement == "link" || currentElement == "pubDate"{
            foundCharacters += string
        }
    }
    
    
    func parser(parser: NSXMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        if !foundCharacters.isEmpty {
            
            if elementName == "link"{
                foundCharacters = (foundCharacters as NSString).substringFromIndex(3)
            }
            
            currentDataDictionary[currentElement] = foundCharacters
            
            
            
            if currentElement == "pubDate" {
                let dateFormatter = NSDateFormatter()
                
                dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss +0000"
                //dateFormatter.dateFormat = "yyyy-MM-dd"
                
                if currentDataDictionary["pubDate"] != nil {
                    let dateString = dateFormatter.dateFromString(currentDataDictionary["pubDate"]!)
                    print(dateString)
                    
                    // Get Current Date
                    let date = NSDate()
                    let formatter = NSDateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
                    let currentDate = formatter.stringFromDate(date)
                    print(currentDate)
                    
                    // Calculate difference of dates
                    let cal = NSCalendar.currentCalendar()
                    
                    var calendar: NSCalendar = NSCalendar.currentCalendar()
                    let flags = NSCalendarUnit.Day
                    
                    let components = calendar.components(flags, fromDate: dateString!, toDate: date, options: [])
                    
                    print(components.day)
                    
                    currentDataDictionary[currentElement] = String(components.day)
                    arrParsedData.append(currentDataDictionary)
                    
                }
                
            }
            
            foundCharacters = ""
            
            
            
            
            
            
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError.description)
    }
    
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print(validationError.description)
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        delegate?.parsingWasFinished()
    }
    
}
