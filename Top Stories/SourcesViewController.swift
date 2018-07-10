//
//  ViewController.swift
//  Top Stories
//
//  Created by Jason Dong on 7/10/18.
//  Copyright © 2018 Jason Dong. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {

    
    var sources = [[String: String]]()
    let apiKey = "5d892509a49046a087917c466fa80d09"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News Source"
          let query = "https://newsapi.org/v1/sources?language=en&country=us&apiKey=\(apiKey)"
    }

    func parse(json: JSON) {
        for result in json["sources"].arrayValue{
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

