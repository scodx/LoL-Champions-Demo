//
//  DetailViewController.swift
//  LoL Champions
//
//  Created by Oscar on 02/07/15.
//  Copyright (c) 2015 uinik. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var championNameLabel: UILabel!
    @IBOutlet var championTitleLabel: UILabel!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    

    func configureView() {
        // Update the user interface for the detail item.
        
        if let detail: AnyObject = self.detailItem {
            /*
            championNameLabel.text = detail.name
            championTitleLabel.text = detail.title
            */
            
            println(detail)
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        
        let url = NSURL(string: currentChampion["img_skin"]!)
        
        let urlRequest = NSURLRequest(URL: url!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            if error != nil {
                println(error)
            } else {
                if let imgSkin = UIImage(data: data) {
                    self.image.image = imgSkin
                }
            }
        }

        
        championNameLabel.text = currentChampion["name"]
        championTitleLabel.text = currentChampion["title"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



























