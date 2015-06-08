//
//  StatesViewController.swift
//  Brewstribution
//
//  Created by Scott Nadeau on 6/8/15.
//  Copyright (c) 2015 Scott Nadeau. All rights reserved.
//

import UIKit
import Parse

class StatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var statesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var brewery: PFObject?
    var states: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statesTableView.hidden = true
        statesTableView.delegate = self
        statesTableView.dataSource = self
        
        if brewery != nil {
            self.navigationItem.title? = brewery!["name"] as! String
            activityIndicator.startAnimating()
            let distributionsQuery = PFQuery(className: "Distribution")
            distributionsQuery.whereKey("brewery", equalTo: brewery!)
            distributionsQuery.includeKey("state")
            distributionsQuery.orderByAscending("state")
            distributionsQuery.findObjectsInBackgroundWithBlock() {(objects, error) -> Void in
                if (error != nil) {
                    println("error finding distributions \(error)")
                } else {
                    let distributions = objects as! [PFObject]
                    self.states = [PFObject]()
                    for distribution in distributions {
                        let state = distribution["state"] as! PFObject
                        self.states!.append(state)
                    }
                    self.activityIndicator.stopAnimating()
                    self.statesTableView.reloadData()
                    self.statesTableView.hidden = false
                    //Debugging purposes
                    for state in self.states! {
                        let stateName = state["name"] as! String
                        println(stateName)
                    }
                }
            }
        }
        
        //Debugging purposes
        if let breweryName = brewery?["name"] as? String {
            println("\(breweryName) selected")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (states != nil) {
            return states!.count
        } else {return 0}
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stateCell") as! UITableViewCell
        let state = states![indexPath.row] as PFObject
        let stateName = state["name"] as! String
        cell.textLabel?.text = stateName
        return cell
    }

}
