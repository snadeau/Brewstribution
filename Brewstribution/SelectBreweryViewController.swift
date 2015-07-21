//
//  SelectBreweryViewController.swift
//  Brewstribution
//
//  Created by Scott Nadeau on 6/4/15.
//  Copyright (c) 2015 Scott Nadeau. All rights reserved.
//

import UIKit
import Parse


class SelectBreweryViewController: UIViewController, MLPAutoCompleteTextFieldDataSource, MLPAutoCompleteTextFieldDelegate {

    @IBOutlet weak var breweryPicker: UIPickerView!
    @IBOutlet weak var autoCompleteBreweryPicker: MLPAutoCompleteTextField!
    
    var breweries: [PFObject]?
    
    var selectedBrewery: String?
    
    var breweryNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        let breweryQuery = PFQuery(className: "Brewery")
        breweryQuery.limit = 1000
        breweryQuery.orderByAscending("name")
        breweryQuery.findObjectsInBackgroundWithBlock() { (objects, error) -> Void in
            if error != nil {
                println("error getting breweries \(error)")
            }
            else {
                self.breweries = objects as! [PFObject]?
                for brewery in self.breweries! {
                    self.breweryNames.append(brewery["name"] as! String)
                }
            }
        }
        
        
        autoCompleteBreweryPicker.autoCompleteDataSource = self
        autoCompleteBreweryPicker.autoCompleteDelegate = self
        autoCompleteBreweryPicker.maximumNumberOfAutoCompleteRows = 5
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "showStates" {
                let dvc = segue.destinationViewController as! StatesViewController
                if breweries != nil {
                    for brewery in breweries! {
                        if brewery["name"] as! String == selectedBrewery! {
                            dvc.brewery = brewery
                        }
                    }
                }
            }
        }
    }
    
    func autoCompleteTextField(textField: MLPAutoCompleteTextField!, possibleCompletionsForString string: String!) -> [AnyObject]! {
        return breweryNames
    }

    func autoCompleteTextField(textField: MLPAutoCompleteTextField!, didSelectAutoCompleteString selectedString: String!, withAutoCompleteObject selectedObject: MLPAutoCompletionObject!, forRowAtIndexPath indexPath: NSIndexPath!) {
        selectedBrewery = selectedString
    }

}
