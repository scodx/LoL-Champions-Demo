//
//  MasterViewController.swift
//  LoL Champions
//
//  Created by Oscar on 02/07/15.
//  Copyright (c) 2015 uinik. All rights reserved.
//

import UIKit
import CoreData


var currentChampion: Dictionary<String, String> = ["name": "", "title": ""]


class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil

    var numChampions = 0
    
    var champions: [Dictionary<String, String>] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        var context: NSManagedObjectContext = appDel.managedObjectContext!
        
        let urlPath = "http://lol.uinik.com/champions"
        
        var url = NSURL(string: urlPath)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
        
            if error != nil{
                println(error)
            }else{
                
                let champions = JSON(data: data)
                
                if champions.count > 0 {
                    
                    self.numChampions = champions.count
                    
                    for (key: String, champion: JSON) in champions{
                        
                        let name = champion["name"].stringValue;
                        let title = champion["title"].stringValue;
                        let img_square = champion["img_square"].stringValue;
                        let img_skin = champion["skins"][0]["img_splash"].stringValue
                        
                        var newChampion = [
                            "name": name,
                            "title": title,
                            "img_square": img_square,
                            "img_skin": img_skin
                        ]
                        
                        self.champions.append(newChampion)
                        
                    }
                    
                }
                
                
                self.tableView.reloadData()
                
            }
        
        })
        
        
        
        task.resume()

        /*
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow(){
                let obj = self.champions[indexPath.row]
                //(segue.destinationViewController as! DetailViewController).detailItem = obj
                currentChampion = obj
            }
            
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numChampions
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = champions[indexPath.row]["name"]
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    
}

