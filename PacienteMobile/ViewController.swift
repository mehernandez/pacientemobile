//
//  ViewController.swift
//  PacienteMobile
//
//  Created by Mario Hernandez on 14/03/15.
//  Copyright (c) 2015 Equinox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logear() {
        
        var googleUrl = NSURL(string: "http://neuromed.herokuapp.com/api/doctor")
        
        var request = NSMutableURLRequest(URL: googleUrl!)
        request.HTTPMethod = "GET"
        request.addValue("text/html", forHTTPHeaderField: "Content-Type")
        
        var session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if((error) != nil) {
                println(error.localizedDescription)
            }
            
            var strData = NSString(data: data, encoding: NSASCIIStringEncoding)
            println(strData)
        })
        
        task.resume()
        
        
        
        
        //let url = NSURL(string: "http://neuromed.herokuapp.com/api/doctor")
        
        
        
      //  let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        //    println(NSString(data: data, encoding: NSUTF8StringEncoding))
           
            
        //}
        
       // task.resume()
        
    }

    
    

    func parseJSON(inputData: NSData) -> Array<NSDictionary>{
        var error: NSError?
        var boardsDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as Array<NSDictionary>
        
        return boardsDictionary
    }
    
    func HTTPsendRequest(request: NSMutableURLRequest,
        callback: (String, String?) -> Void) {
            let task = NSURLSession.sharedSession().dataTaskWithRequest(
                request,
                {
                    data, response, error in
                    if error != nil {
                        callback("", error.localizedDescription)
                    } else {
                        callback(
                            NSString(data: data, encoding: NSUTF8StringEncoding)!,
                            nil
                        )
                    }
            })
            
            task.resume()
    }
    
  // otro intento
    
    
}

