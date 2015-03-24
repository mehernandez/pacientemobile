//
//  Connector.swift
//  DoctorApp
//
//  Created by Felipe Macbook Pro on 3/16/15.
//  Copyright (c) 2015 Felipe-Otalora. All rights reserved.
//



import Foundation

class Connector  {
    
    let method : String
    let requestUrl = "http://neuromed.herokuapp.com/api"
    
     var result : NSDictionary?

    
     init(){
       // super.viewDidLoad()
        self.method = ""
        
        
    }
    
    func postData(url: String , data: NSData , vista : NuevoEpisodioViewController){
        
        var request = NSMutableURLRequest(URL: NSURL(string : requestUrl+url)!)
        request.HTTPMethod = "PUT"
        
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration, delegate: vista , delegateQueue : NSOperationQueue.mainQueue())
        
        var task = session.uploadTaskWithRequest(request, fromData: data)
        
        task.resume()
        
        
    }
    
    func extraPost( urlll : String ,  array : [String: AnyObject] , verb : String ) {
    
        var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var session = NSURLSession(configuration: configuration)
        var usr = "dsdd"
        var pwdCode = "dsds"
        let params:[String: AnyObject] = [
            "email" : usr,
            "userPwd" : pwdCode ]
        
       
        
        
        
        let url = NSURL(string:requestUrl+urlll)
        let request = NSMutableURLRequest(URL: url!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPMethod = verb
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(array, options: NSJSONWritingOptions.allZeros, error: &err)
        
        let task = session.dataTaskWithRequest(request) {
            data, response, error in
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    println("response was not 200: \(response)")
                    return
                }
            }
            if (error != nil) {
                println("error submitting request: \(error)")
                return
            }
            
            // handle the data of the successful response here
            self.result = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as? NSDictionary
            println(self.result)
        }
        task.resume()
        
        
        
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
    
    func fileUpload( urll : String , dat : NSData){
        
        let file = NSString(data: dat, encoding: NSUTF8StringEncoding)
        
        let url = NSURL(string: requestUrl + urll)
        let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        var request = NSMutableURLRequest(URL: url!, cachePolicy: cachePolicy, timeoutInterval: 2.0)
        request.HTTPMethod = "PUT"
        
        // set Content-Type in HTTP header
        let boundaryConstant = "----------V2ymHFg03esomerandomstuffhbqgZCaKO6jy";
        let contentType = "multipart/form-data; boundary=" + boundaryConstant
        NSURLProtocol.setProperty(contentType, forKey: "Content-Type", inRequest: request)
        
        // set data
        
        let requestBodyData = file?.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = requestBodyData
        
        // set content length
        //NSURLProtocol.setProperty(requestBodyData.length, forKey: "Content-Length", inRequest: request)
        
        var response: NSURLResponse? = nil
        var error: NSError? = nil
        let reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
        
        let results = NSString(data:reply!, encoding:NSUTF8StringEncoding)
        println("API Response: \(results)")
        
    }
    
    
    
    }