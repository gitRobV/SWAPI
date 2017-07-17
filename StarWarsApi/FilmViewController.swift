//
//  FilmViewController.swift
//  StarWarsApi
//
//  Created by Robert on 7/17/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit

class FilmViewController: UITableViewController {
    
    var films = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "http://swapi.co/api/films")
        
        let session = URLSession.shared
        
        let request = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            do {
                if let requestResults = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    let jsonFilms = requestResults["results"] as! NSArray
                    for object in jsonFilms {
                        let film = object as! NSDictionary
                        let name = film["title"]
                        self.films.append(name as! String)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            } catch {
                print(error)
            }
        })
        request.resume()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = films[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
