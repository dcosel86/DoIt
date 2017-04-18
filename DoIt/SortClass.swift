//
//  SortClass.swift
//  DoIts
//
//  Created by Amanda Cosel on 4/15/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import Foundation
import CoreData
import UIKit



var sorting : Sorting? = Sorting()

class Sorting {
    
    var sortSelection : Int = 3
    var sortName : String = ""
    
    func determineSortLabels() {
        
        if sortSelection == 0 {
                       sortName = "Priority"
            
        }
        
        if sortSelection == 1 {
            
            
            
           
            
            sortName = "Due Date"
        }
        
        if sortSelection == 2 {
            
           sortName = "Created Date"
            
        }
        
        if sortSelection == 3 {
                       sortName = "Task Name"
          
        }

        
        
    }

}
