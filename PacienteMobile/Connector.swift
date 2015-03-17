//
//  Connector.swift
//  DoctorApp
//
//  Created by Felipe Macbook Pro on 3/16/15.
//  Copyright (c) 2015 Felipe-Otalora. All rights reserved.
//

import Foundation

class Connector {
    
    let method : String
    let requestUrl = "http://neuromed.herokuapp.com/api"
    
    init(){
        self.method = ""
    }
    
    func doGet(target : String) -> NSArray{
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: requestUrl + target)
        request.HTTPMethod = "GET"
        
        var response: NSURLResponse?
        
        var err: AutoreleasingUnsafeMutablePointer<NSError?> = nil
        
        let urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: err)
        
        //WARNING! Check if json response is an ARRAY or a DICTIONARY, in that case, cast the method accordingly
        var jsonResult: NSArray = NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers, error:err) as NSArray
        
        return jsonResult
    }
    
    func doAsyncGet(uri : String) -> NSArray{
        var request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: requestUrl + uri)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            let jsonString: String = String(contentsOfURL: request.URL!, encoding: NSASCIIStringEncoding, error: error)!
            
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
                // process jsonResult
                
            } else {
                // couldn't load JSON, look at error
                println("Error: \(error.debugDescription)")
            }
            
            
        })
        return NSArray(object: "null")
    }
}