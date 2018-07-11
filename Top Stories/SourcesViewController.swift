//
//  ViewController.swift
//  Top Stories
//
//  Created by Jason Dong on 7/10/18.
//  Copyright © 2018 Jason Dong. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController{
    
    @IBAction func onTappedDoneButton(_ sender: Any) {
        exit(0)
    }
    //var sources = [[String: String]]()
    var gender = [String]()
    var nameKey = "episode"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Rick and Morty Episodes"
        gender.append("episode/1")
        gender.append("episode/2")
        gender.append("episode/3")
        gender.append("episode/4")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gender.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let source = gender[indexPath.row]
        cell.textLabel?.text = source
        return cell
    }
    
    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error",
                                          message: "There was a problem loading the feed",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ArticlesViewController
        let index = tableView.indexPathForSelectedRow?.row
        nameKey = gender[index!]
        dvc.query = "https://rickandmortyapi.com/api/character/\(nameKey)"
    }
}

