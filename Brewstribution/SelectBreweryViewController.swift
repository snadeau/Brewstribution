//
//  SelectBreweryViewController.swift
//  Brewstribution
//
//  Created by Scott Nadeau on 6/4/15.
//  Copyright (c) 2015 Scott Nadeau. All rights reserved.
//

import UIKit
import Parse

class SelectBreweryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var breweryPicker: UIPickerView!
    
    var breweries: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        breweryPicker.delegate = self
        breweryPicker.dataSource = self
        
        let breweryQuery = PFQuery(className: "Brewery")
        breweryQuery.limit = 1000
        breweryQuery.orderByAscending("name")
        breweryQuery.findObjectsInBackgroundWithBlock() { (objects, error) -> Void in
            if error != nil {
                println("error getting breweries \(error)")
            }
            else {
                self.breweries = objects as! [PFObject]?
                self.breweryPicker.reloadAllComponents()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "showStates" {
                let dvc = segue.destinationViewController as! StatesViewController
                if breweries != nil {
                    dvc.brewery = breweries![breweryPicker.selectedRowInComponent(0)]
                }
            }
        }
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if breweries == nil {
            return 0
        } else {
            return breweries!.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return breweries![row]["name"] as! String
    }

}
