//
//  SelectTwoStatesViewController.swift
//  Brewstribution
//
//  Created by Scott Nadeau on 6/8/15.
//  Copyright (c) 2015 Scott Nadeau. All rights reserved.
//

import UIKit
import Parse

class SelectTwoStatesViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var state1Input: UITextField!

    
    var state1ActionPicker: ActionSheetStringPicker!
    var state2ActionPicker: ActionSheetStringPicker!
    
    var states: [PFObject]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stateQuery = PFQuery(className: "State")
        stateQuery.orderByAscending("name")
        stateQuery.findObjectsInBackgroundWithBlock() { (objects, error) -> Void in
            if error != nil {
                println("error getting states \(error)")
            }
            else {
                self.states = objects as! [PFObject]?
                
            }
        }
    }
}
