//
//  ViewController.swift
//  Top Stories
//
//  Created by Jason Dong on 7/10/18.
//  Copyright © 2018 Jason Dong. All rights reserved.
//

import UIKit

class ArticlesViewController: UITableViewController {
    
    var episodes = [[String: String]]()
    var nameKey = ""
    var source = [String: String]()
    var query : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rick and Morty Episodes"
        DispatchQueue.global(qos: .userInitiated) .async {
            [unowned self] in
            if let url = URL(string: self.query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = episodes[indexPath.row]
        cell.textLabel?.text = article["name"]
        cell.detailTextLabel?.text = article["url"]
        return cell
    }
    
    func parse(json: JSON){
        for result in json["info"].arrayValue {
            let airDate = result["air_date"].stringValue
            let name = result["name"].stringValue
            let imageURL = result["url"].stringValue
            let source = ["air_date": airDate, "name": name, "url": imageURL]
            episodes.append(source)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Problem Loading",
                                          message: "Can't load the page",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: episodes[indexPath.row]["url"]!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
}

