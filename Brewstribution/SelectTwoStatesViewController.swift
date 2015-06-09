//
//  SelectTwoStatesViewController.swift
//  Brewstribution
//
//  Created by Scott Nadeau on 6/8/15.
//  Copyright (c) 2015 Scott Nadeau. All rights reserved.
//

import UIKit
import Parse

class SelectTwoStatesViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var state1PickerView: UIPickerView!
    @IBOutlet weak var state2PickerView: UIPickerView!
    
    var states: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state1PickerView.delegate = self
        state1PickerView.dataSource = self
        state2PickerView.delegate = self
        state2PickerView.dataSource = self
        
        let stateQuery = PFQuery(className: "State")
        stateQuery.orderByAscending("name")
        stateQuery.findObjectsInBackgroundWithBlock() { (objects, error) -> Void in
            if error != nil {
                println("error getting states \(error)")
            }
            else {
                self.states = objects as! [PFObject]?
                self.state1PickerView.reloadAllComponents()
                self.state2PickerView.reloadAllComponents()
            }
        }
        
    }

    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let identifier = segue.identifier {
//            if identifier == "showBreweries" {
//                let dvc = segue.destinationViewController as! BreweriesViewController
//                if states != nil {
//                    let state = states![statePicker.selectedRowInComponent(0)]
//                    dvc.state = state
//                }
//            }
//        }
//    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if states == nil {
            return 0
        } else {
            return states!.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return states![row]["name"] as! String
    }

}
