//
//  BSBrewery.swift
//  Brewstribution
//
//  Created by Scott Nadeau on 7/20/15.
//  Copyright (c) 2015 Scott Nadeau. All rights reserved.
//

import Foundation
import Parse

class BSBrewery : PFObject, PFSubclassing, MLPAutoCompletionObject {
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Brewery"
    }
    
    @NSManaged var name : String?
    @NSManaged var distributions: [BSDistribution]
    
    func autocompleteString() -> String! {
        if name != nil {
            return name!
        } else {
            return ""
        }
    }
}
