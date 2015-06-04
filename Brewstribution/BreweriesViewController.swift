//
//  BreweriesViewController.swift
//  Brewstribution
//
//  Created by Scott Nadeau on 6/3/15.
//  Copyright (c) 2015 Scott Nadeau. All rights reserved.
//

import UIKit
import Parse

class BreweriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var breweriesTableView: UITableView!
    
    var state: PFObject?
    var breweries: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breweriesTableView.hidden = true
        breweriesTableView.delegate = self
        breweriesTableView.dataSource = self
        
        if state != nil {
            self.navigationItem.title? = state!["name"] as! String
            activityIndicator.startAnimating()
            let distributionsQuery = PFQuery(className: "Distribution")
            distributionsQuery.whereKey("state", equalTo: state!)
            distributionsQuery.includeKey("brewery")
            distributionsQuery.orderByAscending("brewery")
            distributionsQuery.findObjectsInBackgroundWithBlock() {(objects, error) -> Void in
                if (error != nil) {
                    println("error finding distributions \(error)")
                } else {
                    let distributions = objects as! [PFObject]
                    self.breweries = [PFObject]()
                    for distribution in distributions {
                        let brewery = distribution["brewery"] as! PFObject
                        self.breweries!.append(brewery)
                    }
                    self.activityIndicator.stopAnimating()
                    self.breweriesTableView.reloadData()
                    self.breweriesTableView.hidden = false
                    //Debugging purposes
                    for brewery in self.breweries! {
                        let breweryName = brewery["name"] as! String
                        println(breweryName)
                    }
                }
            }
        }
        
        //Debugging purposes
        if let stateName = state?["name"] as? String {
            println("\(stateName) selected")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (breweries != nil) {
            return breweries!.count
        } else {return 0}
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("breweryCell") as! UITableViewCell
        let brewery = breweries![indexPath.row] as PFObject
        let breweryName = brewery["name"] as! String
        cell.textLabel?.text = breweryName
        return cell
    }

}
