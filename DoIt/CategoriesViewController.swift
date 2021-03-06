//
//  CategoriesViewController.swift
//  DoIt
//
//  Created by Amanda Cosel on 2/26/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import CoreData

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var categoriesTableView: UITableView!
    
    @IBOutlet weak var newCategoryName: UITextField!
    
    @IBOutlet weak var listDragView: UIView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var categoryTextField: UITextField!
    
  
    @IBOutlet weak var newCategoryButton: UIButton!
    
    
//    @IBOutlet weak var colorPicker: UIView!
  
    @IBOutlet weak var selectedColorView: UIImageView!
    
  
    
    
   
    
   
   // @IBOutlet weak var allDisclosureArrow: UILabel!
    
    var categories : [Category] = []
    var tasks : [Task] = []
    var task : Task? = nil
    var category : Category? = nil
    let alert = UIAlertController(title: "Are you sure?", message: "Deleting a list will move all associated tasks to the Misc list", preferredStyle: .actionSheet)
//    let colors : [UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.darkGray, UIColor.brown]
    var selectedColor : UIColor = UIColor.white
    var editCategory : Category? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        self.categoryTextField.delegate = self
        
//        colorPicker.backgroundColor = colors[1]

        
        
        
        
         listDragView.layer.cornerRadius = 5
//        listDragView.layer.borderWidth = 1
//        listDragView.layer.borderColor = UIColor.black.cgColor
//        listDragView.layer.shadowColor = UIColor.white.cgColor
//        listDragView.layer.shadowOffset = CGSize(width: 2, height: 2)
//        listDragView.layer.shadowRadius = 1
//        listDragView.layer.shadowOpacity = 0.5
        
//        listView.layer.shadowColor = UIColor.black.cgColor
//        listView.layer.shadowOffset = CGSize(width: 2, height: 2)
//        listView.layer.shadowRadius = 1
//        listView.layer.shadowOpacity = 0.5
//         listView.layer.borderWidth = 1
//         listView.layer.borderColor = UIColor.black.cgColor
        
        
//        alert.addAction(UIAlertAction(title: "Sure go ahead", style: .default, handler: { (action) in
//          
//
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
//            
//        }))
        
        
    }
    
     override func viewWillAppear(_ animated: Bool) {
        
        selectedCategory.getCategories()
        categories = selectedCategory.categories
        
       categories.sort(by: {Double(($0.createdDate?.timeIntervalSinceNow)!) < Double(($1.createdDate?.timeIntervalSinceNow)!)})
        
    
      
        getTasks()
        
        determineFillOfColorDot()
        
        
        
//        allDisclosureArrow.text = "\(tasks.count) >"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (categories.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategoryTableViewCell
        
        let category = categories[indexPath.row]
        
        cell.categoryNameLabel.text = "\(category.categoryName!)"
        
        if (category.categoryTasks?.count)! > 1 {
        cell.taskCountLabel.text = "\(category.categoryTasks!.count) Tasks"
        } else if (category.categoryTasks?.count)! == 1  {
            cell.taskCountLabel.text = "1 Task"
        } else {
            cell.taskCountLabel.text = "No Tasks"
        }
        
        
       // cell.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        //cell.layer.borderWidth = 4
        
        cell.categoryColor.backgroundColor = category.color as! UIColor?
        
        return cell
   
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        category = categories[indexPath.row]
        //maskView.isHidden = false
        selectedCategory.category = category
        
         performSegue(withIdentifier: "unwindToSelectedCategory", sender: category)
        
        
    }
    
//    @IBAction func allCategoryTapped(_ sender: Any) {
//        
//        let category : Category? = nil
//
//         performSegue(withIdentifier: "unwindToSelectedCategory", sender: category)
//        
//    }
    
    
//    func getCategories () {
//        
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do{
//            categories = try context.fetch(Category.fetchRequest())
//           
//        } catch {
//        }
//    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if categoryTextField.text != "" {
            
            if editCategory != nil {
                
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                let category2 = editCategory
                category2?.categoryName = newCategoryName.text
                category2?.color = selectedColor
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                selectedCategory.getCategories()
                categories = selectedCategory.categories
                
                categoriesTableView.reloadData()
                
                categories.sort(by: {Double(($0.createdDate?.timeIntervalSinceNow)!) < Double(($1.createdDate?.timeIntervalSinceNow)!)})
                
                
                
                newCategoryName.text = ""
                newCategoryButton.setTitle("Add", for: .normal)
                editCategory = nil
                selectedColor = UIColor.white
                self.viewDidLoad()
                
                
                
            } else {
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let category = Category(context: context)
            
            category.categoryName = newCategoryName.text
            category.createdDate = NSDate()
            category.color = selectedColor
           // category.isSelected = false
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            selectedCategory.getCategories()
            categories = selectedCategory.categories
            
            categoriesTableView.reloadData()
            
            
            
            
            categories.sort(by: {Double(($0.createdDate?.timeIntervalSinceNow)!) < Double(($1.createdDate?.timeIntervalSinceNow)!)})
            
            
            
            newCategoryName.text = ""

            }
        }
         categoryTextField.resignFirstResponder()
        return (true)
    }
    
    func getTasks () {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            tasks = try context.fetch(Task.fetchRequest())
        } catch {
        }}
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row > 0
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        
        var editRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Edit", handler:{action, indexpath in
           
            self.editCategory = self.categories[indexPath.row]
            let categoryName = self.editCategory?.categoryName
            let categoryColor = self.editCategory?.color
           self.categoryTextField.text = categoryName
            self.selectedColor = categoryColor as! UIColor
            self.newCategoryButton.setTitle("Update", for: .normal)
            
            if categoryColor == UIColor.white{
                
                self.selectedColorView.image = UIImage(named: "Full Moon-50.png")?.withRenderingMode(.alwaysTemplate)
                self.selectedColorView.tintColor = UIColor.black
                
                
                
            } else {
                
                self.selectedColorView.image = UIImage(named: "circleSlider.png")?.withRenderingMode(.alwaysTemplate)
                self.selectedColorView.tintColor = categoryColor as! UIColor!
            }
            

            self.categoriesTableView.reloadData()
            
        });

        editRowAction.backgroundColor = UIColor.lightGray
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",  handler:{action, indexpath in
            print("DELETE•ACTION");
            
           self.present(self.alert, animated: true, completion: nil)
            
            self.alert.addAction(UIAlertAction(title: "Sure go ahead", style: .default, handler: { (action) in
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let entity = NSEntityDescription.entity(
                    forEntityName: "Task", in: context)
                let request: NSFetchRequest<Task> = Task.fetchRequest()
                request.entity = entity

                
                
                let deletedCategory = self.categories[indexPath.row]
                let categoryName = deletedCategory.categoryName
                var affectedTasks : [Task] = []
                
                
                
               
                let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (categoryName)!)
                let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predCat])
                
                request.predicate = predicateCompound
                do{
                    affectedTasks = try context.fetch(request as!
                        NSFetchRequest<NSFetchRequestResult>) as! [Task]
                    
                    
                
                    
                } catch {}
            
                
                for task in affectedTasks {
                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    task.taskCategory = self.categories[0]
                     (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    
                }

                
//                affectedTasks.forEach {
//                    $0.taskCategory!.categoryName = "Misc"
//                    print($0.taskCategory?.categoryName)
//                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
//                
//                }
                
                
                
                
                            context.delete(deletedCategory)
                
                
                
                            (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                            selectedCategory.getCategories()
                            self.categories = selectedCategory.categories
                
                            self.categoriesTableView.reloadData()
                
            
                if deletedCategory == self.category {
                            self.category = self.categories[0]
                }else {
                    self.category == self.category
                }
                
            }))
            self.alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                self.categoriesTableView.reloadData()
            }))

       
            
//            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//            let category = self.categories[indexPath.row]
//            context.delete(category)
//            
//            (UIApplication.shared.delegate as! AppDelegate).saveContext()
//            
//            self.getCategories()
//            
//            self.categoriesTableView.reloadData()
  
        });
        
    
        return [deleteRowAction, editRowAction];
        }

    
    
    //actions
    
    
    
    
    
    
   
    @IBAction func newCategoryButtonTapped(_ sender: Any) {
        
        
        
        if categoryTextField.text != "" {
            
            if editCategory != nil {
                
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                let category2 = editCategory
                category2?.categoryName = newCategoryName.text
                category2?.color = selectedColor
                
                 (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                selectedCategory.getCategories()
                categories = selectedCategory.categories
                
                categoriesTableView.reloadData()
                
                categories.sort(by: {Double(($0.createdDate?.timeIntervalSinceNow)!) < Double(($1.createdDate?.timeIntervalSinceNow)!)})
                
                
                
                newCategoryName.text = ""
                newCategoryButton.setTitle("Add", for: .normal)
                editCategory = nil
                selectedColor = UIColor.white
                self.viewDidLoad()

                
            } else {
            
            
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let category = Category(context: context)

        category.categoryName = newCategoryName.text
        category.createdDate = NSDate()
        category.color = selectedColor
            
            print(category.color)
        //category.isSelected = false
    
        
         (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        selectedCategory.getCategories()
                categories = selectedCategory.categories
        
        categoriesTableView.reloadData()
                
        
        
            
            categories.sort(by: {Double(($0.createdDate?.timeIntervalSinceNow)!) < Double(($1.createdDate?.timeIntervalSinceNow)!)})
            
       
        
        newCategoryName.text = ""
            } }
        
        self.selectedColorView.image = UIImage(named: "Full Moon-50.png")?.withRenderingMode(.alwaysTemplate)
        self.selectedColorView.tintColor = UIColor.black
        
    }
    
    
    @IBAction func tapOutOfCats2(_ sender: UITapGestureRecognizer) {
        
        self.performSegue(withIdentifier: "unwindToSelectedCategory", sender: category)
    }
    
    
    
   
    @IBAction func tapOutOfCats(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToSelectedCategory", sender: category)
    }
    
    
    @IBAction func swipeOutOfCats(_ sender: UISwipeGestureRecognizer) {
        
         self.performSegue(withIdentifier: "unwindToSelectedCategory", sender: category)
    }
  
 
    
    
    
//    @IBAction func categoriesDismissed(_ sender: UITapGestureRecognizer) {
//         performSegue(withIdentifier: "unwindToSelectedCategory", sender: self)
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "unwindToSelectedCategory" {
        let nextVC = segue.destination as! TasksViewController
            
            if category != nil {
        nextVC.category = sender as? Category
                nextVC.selectedColor = self.selectedColor
            } else {
                
                nextVC.category = nil
                nextVC.selectedColor = UIColor.white
            }
            
        }
    }
    
    
    
//    @IBAction func tapColorPicker(_ sender: UITapGestureRecognizer) {
//        
//        if colorPicker.backgroundColor == colors[0] {
//        colorPicker.backgroundColor = colors[1]
//        } else if colorPicker.backgroundColor == colors[1]{
//            colorPicker.backgroundColor = colors[2]
//        }else if colorPicker.backgroundColor == colors[2]{
//            colorPicker.backgroundColor = colors[3]
//        } else if colorPicker.backgroundColor == colors[3]{
//        colorPicker.backgroundColor = colors[4]
//        } else if colorPicker.backgroundColor == colors[4]{
//            colorPicker.backgroundColor = colors[0]
//        }
//
//
//
//        
//    }
    
    
    @IBAction func unwindToCatsFromColors(segue: UIStoryboardSegue) {

       determineFillOfColorDot()
    }
    
    func determineFillOfColorDot() {
        if selectedColor == UIColor.white{
            
            selectedColorView.image = UIImage(named: "Full Moon-50.png")?.withRenderingMode(.alwaysTemplate)
            selectedColorView.tintColor = UIColor.black
            
            
            
        } else {
            
            selectedColorView.image = UIImage(named: "circleSlider.png")?.withRenderingMode(.alwaysTemplate)
            selectedColorView.tintColor = selectedColor
        }
    
    }
    
    @IBAction func viewAllButtonTapped(_ sender: Any) {
        
        selectedCategory.category = nil
        
        performSegue(withIdentifier: "unwindToSelectedCategory", sender: category)
    }
    
    
    
}
