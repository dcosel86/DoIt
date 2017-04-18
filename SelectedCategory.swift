//
//  SelectedCategory.swift
//  DoIts
//
//  Created by Amanda Cosel on 4/15/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var selectedCategory : SelectedCategory = SelectedCategory()

class SelectedCategory {
    
    var category : Category? = nil
    var categories : [Category] = []
    
    func getCategories () {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            categories = try context.fetch(Category.fetchRequest())
        } catch {
        }
    }
    
    
    


}
