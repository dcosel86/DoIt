//
//  FIltersClass.swift
//  DoIts
//
//  Created by Amanda Cosel on 4/14/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import Foundation
import CoreData
import UIKit



var filters : Filters? = Filters()

class Filters {
    
     var filterSelections : [Bool] = [false, false, false, false, false, true, true]
    var name : String = "Show All"
    let calendar = Calendar.current
    
    var category = selectedCategory.category
    var tasks : [Task] = []
  
    
    func determineFilters() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(
            forEntityName: "Task", in: context)
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.entity = entity
        
        let todaysDate = Date()
        
        //from date
        let fromDate = calendar.startOfDay(for: todaysDate)
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond],from: todaysDate)
        
        let selectedCategoryName = selectedCategory.category?.categoryName
        
        
        //no filter/categories- show all tasks
        if (selectedCategory.category != nil && filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true) == true{
            // let pred = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
            let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predCat])
            
            request.predicate = predicateCompound
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                
                
                name = "Show All"
                
            } catch {}
        }
        
        //no filter/no categories - show all tasks
        if (selectedCategory.category == nil && filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true) == true{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do{
                tasks = try context.fetch(Task.fetchRequest())
                
                
                name = "Show All"
            } catch {}
        }
        
        
        
        //show only completed
        if (filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false) == true {
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            
            if selectedCategoryName != nil {
                
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2,predCat])
                request.predicate = predicateCompound
            } else {
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Completed"
                
                
            } catch {}
            
        }
        
        //show only not completed
        if (filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true) == true {
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            
            if selectedCategoryName != nil {
                
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2,predCat])
                request.predicate = predicateCompound
            } else {
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Not completed"
            } catch {}
            
        }
        
        //show only important tasks: all
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true {
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            
            
            if selectedCategoryName != nil {
                
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predCat])
                request.predicate = predicateCompound
            } else {
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Urgent"
            } catch {}
            
        }
        
        
        
        
        
        //show only important tasks: not complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true {
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            
            if selectedCategoryName != nil {
                
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2,predCat])
                request.predicate = predicateCompound
            } else {
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Urgent"
            } catch {}
            
        }
        
        
        //show only important tasks: complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false {
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            
            if selectedCategoryName != nil {
                
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2,predCat])
                request.predicate = predicateCompound
            } else {
                
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate1,predicate2])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Urgent"
            } catch {}
            
        }
        
        //show todays tasks only:all
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Due Today"
            } catch {}
        }
        
        
        
        
        
        //show todays tasks only: not complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Due Today"
            } catch {}
        }
        
        //show todays tasks only: complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Due Today"
            } catch {}
        }
        
        
        //show only this weeks tasks: all
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Due this week"
            } catch {}
        }
        
        
        
        
        //show only this weeks tasks: not complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Due this week"
            } catch {}
        }
        
        
        
        //show only this weeks tasks: complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Due this week"
            } catch {}
        }
        
        //show only past due tasks: all
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Past Due"
            } catch {}
        }
        
        
        
        
        //show only past due tasks: not complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Past Due"
            } catch {}
        }
        
        
        
        
        //show only past due tasks: complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
               name = "Past Due"
            } catch {}
        }
        
        //show past due and important tasks: all
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Past Due, Urgent"
            } catch {}
        }
        
        
        
        
        //show past due and important tasks: not complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
              name = "Past Due, Urgent"
            } catch {}
        }
        
        
        
        //show past due and important tasks: complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                
                name = "Past Due, Urgent"
            } catch {}
        }
        
        //show this weeks,todays that are important: all
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true {
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Due this week, Urgent"
            } catch {}
        }
        
        //show this weeks,todays that are important: not complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true {
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due this week, Urgent"
            } catch {}
        }
        
        
        
        
        //show this weeks,todays that are important: complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false {
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due this week, Urgent"
            } catch {}
        }
        
        //show todays that are important: all
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, Urgent"
            } catch {}
        }
        
        
        
        
        //show todays that are important: not complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, Urgent"
            } catch {}
        }
        
        
        //show todays that are important: complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, Urgent"
            } catch {}
        }
        
        
        //show past due + this week + today that are important: all
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due this week, Urgent"
            } catch {}
        }
        
        //show past due + this week + today that are important: not complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due this week, Urgent"
            } catch {}
        }
        
        
        //show past due + this week + today that are important: complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due this week, Urgent"
            } catch {}
        }
        
        //show past due + today that are important: all
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today, Urgent"
            } catch {}
        }
        
        
        //show past due + today that are important: not complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today, Urgent"
            } catch {}
        }
        
        
        //show past due + today that are important: complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today, Urgent"
            } catch {}
        }
        
        //show past due + week + today: all
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past Due, Due this week"
            } catch {}
            
        }
        
        
        
        //show past due + week + today: not complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due this week"
            } catch {}
            
        }
        
        //show past due + week + today: complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due this week"
            } catch {}
            
        }
        
        
        //show today + past due:all
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today"
            } catch {}
            
        }
        
        
        //show today + past due: not complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past Due, Due today"
            } catch {}
            
        }
        
        //show today + past due: complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today"
            } catch {}
            
        }
        
        //show past due + today that are important & audio: not complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past Due, Due today, Urgent, audio"
            } catch {}
        }
        
        
        //show past due + today that are important & audio: all
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today, Urgent, audio"
            } catch {}
        }
        
        
        
        
        
        //show past due + today that are important & audio: complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today, Urgent, audio"
            } catch {}
        }
        
        
        
        //show past due + today & audio: all
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today, audio"
            } catch {}
        }
        
        
        //show past due + today & audio: not complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today, audio"
            } catch {}
        }
        
        //show past due + today & audio: complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toTodaysDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, Due today, audio"
            } catch {}
        }
        
        //show past due that are important & audio: all
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past Due, Important, audio"
            } catch {}
        }
        
        
        
        //show past due that are important & audio: not complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past Due, Important, audio"
            } catch {}
        }
        
        //show past due that are important & audio: complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past Due, Important, audio"
            } catch {}
        }
        
        
        
        //show past due & audio: all
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past Due, audio"
            } catch {}
        }
        
        
        //show past due & audio: not complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, audio"
            } catch {}
        }
        
        
        //show past due & audio: complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", fromDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past Due, audio"
            } catch {}
        }
        
        
        //show due today that are important & audio: all
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, Urgent, audio"
            } catch {}
        }
        
        
        
        //show due today that are important & audio: not complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, Urgent, audio"
            } catch {}
        }
        
        
        //show due today that are important & audio: complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, Urgent, audio"
            } catch {}
        }
        
        //show due today & audio: all
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, audio"
            } catch {}
        }
        
        
        
        //show due today & audio: not complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, audio"
            } catch {}
        }
        
        //show due today & audio: complete
        if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 1
            
            let comparingDate = calendar.date(from:components)!
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due today, audio"
            } catch {}
        }
        
        
        //show due this week that are important & audio: not complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Due this week, Urgent, audio"
            } catch {}
        }
        
        
        //show due this week that are important & audio:  all
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due this week, Urgent, audio"
            } catch {}
        }
        
        //show due this week that are important & audio: complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Due this week, Urgent, audio"
            } catch {}
        }
        
        
        
        //show due this week & audio: all
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
              name = "Due this week, audio"
            } catch {}
        }
        
        
        
        //show due this week & audio: not complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Due this week, audio"
            } catch {}
        }
        
        
        //show due this week & audio: complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toNextWeeksDate])
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Due this week, audio"
            } catch {}
        }
        
        
        //show past due, due this week that are important & audio: all
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past due, Due this week, Urgent, audio"
            } catch {}
        }
        
        
        //show past due, due this week that are important & audio: not complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past due, Due this week, Urgent, audio"
            } catch {}
        }
        
        //show past due, due this week that are important & audio: complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            
            //to todays date
            let toTodaysDate = calendar.startOfDay(for: comparingDate)
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            let predicate1 = NSPredicate(format: "(important == %@)", true as CVarArg )
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
                name = "Past due, Due this week, Urgent, audio"
            } catch {}
        }
        
        
        //show past due, due this week & audio:all
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past due, Due this week, audio"
            } catch {}
        }
        
        //show past due, due this week & audio: not complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past due, Due this week, audio"
            } catch {}
        }
        
        //show past due, due this week & audio: complete
        if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            components.day! += 7
            
            let comparingDate = calendar.date(from:components)!
            let toNextWeeksDate = calendar.startOfDay(for: comparingDate)
            
            
            
            let datePredicate = NSPredicate(format: "(%@ > dueDate)", toNextWeeksDate as CVarArg)
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Past due, Due this week, audio"
            } catch {}
        }
        
        
        //show  audio: all
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == true{
            
            
            
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Audio"
            } catch {}
        }
        
        
        //show  audio: not complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == false && filterSelections[6] == true{
            
            
            
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Audio"
            } catch {}
        }
        
        //show  audio: complete
        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true && filterSelections[5] == true && filterSelections[6] == false{
            
            
            
            
            let predicateAudio = NSPredicate(format: "(audioNote != nil)")
            
            
            let predicate2 = NSPredicate(format: "(completed == %@)", true as CVarArg)
            if selectedCategoryName != nil {
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2, predCat, predicateAudio])
                request.predicate = predicateCompound
            }else {
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predicate2, predicateAudio])
                request.predicate = predicateCompound
            }
            
            do{
                tasks = try context.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>) as! [Task]
               name = "Audio"
            } catch {}
        }
        
    }
    
}
