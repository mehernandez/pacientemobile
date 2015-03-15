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
        
        var request = HTTPTask()
        request.GET("http://vluxe.io", parameters: nil, success: {(response: HTTPResponse) in
            if response.responseObject != nil {
                let data = response.responseObject as NSData
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("response: \(str)") //prints the HTML of the page
            }
            },failure: {(error: NSError) in
                println("error: \(error)")
        })
        
    }
    


}

