//
//  QuickAddViewController.swift
//  DoIts
//
//  Created by Amanda Cosel on 4/13/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import CoreData

class QuickAddViewController: UIViewController {
    
    

    @IBOutlet weak var quickAddTextField: UITextField!
    
  
    @IBOutlet weak var quickAddButton: UIButton!
    
    var category = selectedCategory.category
    
    var tasks : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quickAddButton.isEnabled = false

       
    }

    @IBAction func quickAddTextChanged(_ sender: Any) {
        
        quickAddButton.isEnabled = true
        
    }
    
    func getTasks () {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            tasks = try context.fetch(Task.fetchRequest())
        } catch {
        }}
    
    
    
    @IBAction func quickAddButtonTapped(_ sender: Any) {

        category = selectedCategory.category
        
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let task = Task(context: context)
            task.taskName = quickAddTextField.text!
            task.important = false
            task.taskNotes = ""
            task.completed = false
            task.dueDate = nil
            
            if category == nil {
                var quickCategory : [Category]? = nil
                
                let entity = NSEntityDescription.entity(
                    forEntityName: "Category", in: context)
                let request: NSFetchRequest<Category> = Category.fetchRequest()
                request.entity = entity
                let pred = NSPredicate(format: "%K = %@", "categoryName", "Misc")
                request.predicate = pred
                do{
                    quickCategory = try context.fetch(request as!
                        NSFetchRequest<NSFetchRequestResult>) as? [Category]
                    
                } catch {}
                task.setValue(quickCategory?[0], forKey: "taskCategory")
                
            } else {
                task.setValue(category, forKey: "taskCategory")
            }
            task.createdDate = NSDate()
            //            task.audioNote? = nil
            task.taskPriority = Int64((tasks.count))
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
        }
            
        catch {}
        
        
      NotificationCenter.default.post(name: .reload, object: nil)
        
        
        quickAddTextField.text = nil
        quickAddButton.isEnabled = false
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        category = selectedCategory.category
        
        do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let task = Task(context: context)
            task.taskName = quickAddTextField.text!
            task.important = false
            task.taskNotes = ""
            task.completed = false
            task.dueDate = nil
            
            if category == nil {
                var quickCategory : [Category]? = nil
                
                let entity = NSEntityDescription.entity(
                    forEntityName: "Category", in: context)
                let request: NSFetchRequest<Category> = Category.fetchRequest()
                request.entity = entity
                let pred = NSPredicate(format: "%K = %@", "categoryName", "Misc")
                request.predicate = pred
                do{
                    quickCategory = try context.fetch(request as!
                        NSFetchRequest<NSFetchRequestResult>) as? [Category]
                    
                } catch {}
                task.setValue(quickCategory?[0], forKey: "taskCategory")
                
            } else {
                task.setValue(category, forKey: "taskCategory")
            }
            task.createdDate = NSDate()
            //            task.audioNote? = nil
            task.taskPriority = Int64((tasks.count))
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
        }
            
        catch {}
        
        
        NotificationCenter.default.post(name: .reload, object: nil)
        
        
        quickAddTextField.text = nil
        quickAddButton.isEnabled = false
        
       quickAddTextField.resignFirstResponder()
        return (true)
        
    }
    
    
    
    
    

        
        
        
        
    }
    
    


