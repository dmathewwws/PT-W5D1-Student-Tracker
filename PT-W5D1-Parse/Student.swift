//
//  Student.swift
//  PT-W5D1-Parse
//
//  Created by Daniel Mathews on 2016-02-02.
//  Copyright © 2016 Daniel Mathews. All rights reserved.
//

import Foundation
import Parse

class Student:PFObject, PFSubclassing {
    
    @NSManaged var name:String
    
    convenience init(name:String){
        self.init()
        self.name = name
    }
    
    static func parseClassName() -> String {
        return "Student"
    }
    
    
    
}