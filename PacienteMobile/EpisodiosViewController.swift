//
//  EpisodiosViewController.swift
//  PacienteMobile
//
//  Created by Mario Hernandez on 16/03/15.
//  Copyright (c) 2015 Equinox. All rights reserved.
//

import UIKit

class EpisodiosViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    var items = Connector().doGet("/doctor");
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func cerrarSesión(sender: UIBarButtonItem) {
        
            self.dismissViewControllerAnimated(false, completion: nil)
            println("se cerró sesión")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cella")
        tableView.dataSource = self
        
        println(items)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cella") as UITableViewCell
     
     //   cell.textLabel?.text = items[indexPath.row]
       
        
        var x : JSON = JSON(items[indexPath.row])
        
        var c = x["apellido"].string!
        
         cell.textLabel?.text = String(c)
        
        
        
        return cell
        
    }

}