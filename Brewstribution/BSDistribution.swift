//
//  BSDistribution.swift
//  Brewstribution
//
//  Created by Scott Nadeau on 7/20/15.
//  Copyright (c) 2015 Scott Nadeau. All rights reserved.
//

import Foundation
import Parse

class BSDistribution : PFObject, PFSubclassing {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Distribution"
    }
    
    @NSManaged var type : String?
    @NSManaged var brewery : BSBrewery?
    @NSManaged var state : BSState?
}
