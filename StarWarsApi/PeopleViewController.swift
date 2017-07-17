//
//  PeopleViewController.swift
//  StarWarsApi
//
//  Created by Robert on 7/17/17.
//  Copyright © 2017 Robert Villarreal. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    
    var people = [String]()

    
    func jsonRequestTask(from: String) {
        let url = URL(string: from)
        
        let session = URLSession.shared
        
        let request = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            
            do {
                if let requestResults = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    let jsonPeople = requestResults["results"] as! NSArray
                    for object in jsonPeople {
                        let person = object as! NSDictionary
                        let name = person["name"]
                        self.people.append(name as! String)
                    }
                    
                    if requestResults["next"] is NSNull {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                    else {
                        let nextRequest = requestResults["next"] as? String
                        self.jsonRequestTask(from: nextRequest!)
                    }
                }
                
            } catch {
                print(error)
            }
            
        })
        request.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swapi = "http://swapi.co/api/people"
        
        jsonRequestTask(from: swapi)
        

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create a generic cell
        let cell = UITableViewCell()
        // set the default cell label to the corresponding element in the people array
        cell.textLabel?.text = people[indexPath.row]
        // return the cell so that it can be rendered
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

