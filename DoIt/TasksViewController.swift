//
//  TasksViewController.swift
//  DoIt
//
//  Created by Amanda Cosel on 1/28/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import CoreData



class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate{
    
    
    @IBOutlet weak var noTasksLabel: UILabel!
    
    @IBOutlet weak var completedNumberLabel: UILabel!

    @IBOutlet weak var dragMessage: UILabel!
   
    @IBOutlet weak var tableView: UITableView!
    
 
    @IBOutlet weak var editsButton: UIBarButtonItem!

    @IBOutlet weak var didEmButton: UIBarButtonItem!

    @IBOutlet weak var completedButton: UIButton!
    
    
    @IBOutlet weak var taskNumber: UILabel!
    
    @IBOutlet weak var completedTasksButtonView: CompletedTasksButtonView!
    
    @IBOutlet weak var maskView: UIView!

    
//    @IBOutlet weak var categoriesButton: UIBarButtonItem!
    
//    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    @IBOutlet weak var filterButton: UIButton!
    
   
  
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    
    @IBOutlet weak var dragToCreateView: UIView!

    @IBOutlet weak var listDragView: UIView!
    
   // @IBOutlet weak var sortNameLabel: UILabel!
    
    
    @IBOutlet weak var sortView: UIView!
    
    @IBOutlet weak var sortImage: UIImageView!
    @IBOutlet weak var sortLabel: UILabel!
    
    @IBOutlet weak var sortExpand: UIImageView!
    @IBOutlet weak var sortButton: UIButton!
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var filterLabel: UILabel!
    
    
    @IBOutlet weak var filterImage: UIImageView!
    
    @IBOutlet weak var filterExpand: UIImageView!
    
    
    
    
    
    
    
    var tasks : [Task] = []
     // 0:today 1:week 2:past 3:imp 4:audio
    var filterSelections : [Bool] = [false, false, false, false, false]
    //1:priority 2:duedate 3:created
    var sortSelection : Int? = 3
    var category : Category? = nil
    var categories : [Category] = []
    var completedTasks : [Task] = []
    let date = Date()
    let calendar = Calendar.current
    var fromAddList = false
    var fromAddTask = false
    var tasksDueToday : [Task]? = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
      
        
         filterView.layer.cornerRadius = 3
               filterView.layer.borderWidth = 1
                filterView.layer.borderColor = UIColor.lightGray.cgColor
        
        sortView.layer.cornerRadius = 3
        sortView.layer.borderWidth = 1
        sortView.layer.borderColor = UIColor.lightGray.cgColor
       
        
     // listDragView.layer.cornerRadius = 10
//       listDragView.layer.borderWidth = 1
//        listDragView.layer.borderColor = UIColor.lightGray.cgColor
        listDragView.layer.shadowColor = UIColor.darkGray.cgColor
        listDragView.layer.shadowOffset = CGSize(width: 2, height: 0)
        listDragView.layer.shadowRadius = 2
        listDragView.layer.shadowOpacity = 0.5
        
        
        
        
        
       //        if tasks.count > 0 {
//       
//            UserDefaults.init(suiteName: "group.com.dcapps.DoIts.ListWidget")?.setValue("You have \(tasks.count) tasks due today", forKey: "textFromApp")
//       
//        } else {
//            UserDefaults.init(suiteName: "group.com.dcapps.DoIts.ListWidget")?.setValue("You have nothing to do today!", forKey: "textFromApp")
//        }
        
       
        
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        editsButton.tintColor = UIColor.black
        
        UINavigationBar.appearance().barTintColor = UIColor(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
        //
        //
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
      
//        
         //self.navigationItem.rightBarButtonItem?.
        
        removeButton.isEnabled = false
        removeButton.tintColor = UIColor.clear
        
        didEmButton.isEnabled = false
        didEmButton.tintColor = UIColor.clear
        self.tableView.allowsMultipleSelectionDuringEditing = true
        maskView.isHidden = true
   
        
//        self.navigationItem.rightBarButtonItem?
//        filterButton.setImage(UIImage(named: "fb.png"), forState: UIControlState.Normal)
//        //add function for button
//        button.addTarget(self, action: "fbButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
//        //set frame
    
        
        
    }
   
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        
      getCategories()
        
        if categories.count > 0 {
            print("I have a category")
            startUpProcedures()
            
        }else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let MiscCategory = Category(context: context)
           
            
            MiscCategory.categoryName = "Misc"
            MiscCategory.createdDate = NSDate()
            //MiscCategory.isSelected = true
         
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            category = MiscCategory
            
            startUpProcedures()
        }
        

        
        if (tasksDueToday?.count)! > 1 {
            
            UserDefaults.init(suiteName: "group.com.dcapps.DoIts.ListWidget")?.setValue("You have \(tasksDueToday!.count) tasks due today", forKey: "textFromApp")
            
        } else if tasksDueToday?.count == 1{
             UserDefaults.init(suiteName: "group.com.dcapps.DoIts.ListWidget")?.setValue("You have \(tasksDueToday!.count) task due today", forKey: "textFromApp")
        }else {
            UserDefaults.init(suiteName: "group.com.dcapps.DoIts.ListWidget")?.setValue("You have nothing to do today!", forKey: "textFromApp")
        }

        
      

     
        
//        if category != nil {
//            
//            if (filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false) == true {
//            
//                getTasksForCategory()
//                getCompletedTasks()
//                tableView.reloadData()
//                
//                taskCount()
//                
//                noTasks()
//                
//                showCompletedTaskLabel()
//                
//                determineSortOrder()
//
//                categoryNameLabel.text = "Category: \(category!.categoryName!)"
//            }
//            else if (filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false) == false {
//            
//            getCompletedTasks()
//            
//            determineFilters()
//            
//            tableView.reloadData()
//            
//            noTasks()
//            
//            showCompletedTaskLabel()
//            
//            determineSortOrder()
//            
//        }
//            else{
//            
//            categoryNameLabel.text = "Category: All"
//            getTasks()
//            
//            getCompletedTasks()
//            
//            tableView.reloadData()
//            
//            taskCount()
//            
//            noTasks()
//            
//            showCompletedTaskLabel()
//            
//            determineFilters()
//            
//            determineSortOrder()
//
//          
//        
////        tasks.sort(by: {
////            $0.taskPriority < $1.taskPriority
////        })
//        
////        if tasks.count > 0 {
////        let firstTask = IndexPath(row: 0, section: 0)
////        let lastTask = IndexPath(row:(tasks.count)-1, section: 0)
//
//        //prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
//      //  }
//        }
//    
//    }
    }
    
   // func autoGoToTask() {
//        if fromAddList ==  true {
//            performSegue(withIdentifier: "addSegue", sender: [category, self])
//            self.fromAddList = false
//            maskView.isHidden = false
//        }
//        
//        if fromAddTask == true {
//            performSegue(withIdentifier: "showCategories", sender: category)
//            self.fromAddTask = false
//            maskView.isHidden = false
//
//        }
//        
//    }
    
    func getTasksDueToday() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(
            forEntityName: "Task", in: context)
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.entity = entity
        
        let todaysDate = Date()
        
        //from date
        let fromDate = calendar.startOfDay(for: todaysDate)
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond],from: todaysDate)
        
        components.day! += 1
        
        let comparingDate = calendar.date(from:components)!
        
        //to todays date
        let toTodaysDate = calendar.startOfDay(for: comparingDate)
        
        let datePredicate = NSPredicate(format: "(%@ <= dueDate && %@ > dueDate)", argumentArray: [fromDate, toTodaysDate])
        let predicate2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
        
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [datePredicate,predicate2])
        request.predicate = predicateCompound
        do{
            tasksDueToday = try context.fetch(request as!
                NSFetchRequest<NSFetchRequestResult>) as! [Task]
        } catch {}


    
    }
    
   func days() -> Int {
        let task : Task? = nil
        let daysToComplete = Calendar.current.dateComponents([Calendar.Component.day], from: Date(), to: (task?.dueDate)! as Date)
        return daysToComplete.day!
        
    }

    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tasks.count)
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell") as! taskTableViewCell
        let task = tasks[indexPath.row]
        let dateFromTask = task.dueDate
        let dateFromCreation = task.createdDate
        
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfTask = calendar.startOfDay(for: dateFromTask as! Date)
        let startOfCreated = calendar.startOfDay(for: dateFromCreation as! Date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        //let createdDateToShow = dateFormatter.string(from: dateFromCreation as! Date)
       // let dateToShow = dateFormatter.string(from: dateFromTask as! Date)
        let todaysDate = dateFormatter.string(from: Date())
    
        let numOfDays: Int = daysBetweenDates(startDate: startOfToday , endDate: startOfTask as! Date)
        
       
        if numOfDays ==  0 {
            cell.dueDateLabel.text = "Due today"
            cell.dueDateLabel.textColor = UIColor.blue
        } else if numOfDays < 0 {
            cell.dueDateLabel.text = "Past Due"
            cell.dueDateLabel.textColor = UIColor.red
        } else if numOfDays == 1 {
            cell.dueDateLabel.text = "Due: \(numOfDays) day"
            cell.dueDateLabel.textColor = UIColor.lightGray
            } else {
                cell.dueDateLabel.text = "Due: \(numOfDays) days"
            cell.dueDateLabel.textColor = UIColor.lightGray
            }
        
        

        
        /*
        if date >= comparingDate {
            cell.dueDateLabel.isHidden = true
        } else {
            cell.dueDateLabel.isHidden = false
        }
        */
        
        if task.audioNote == nil {
            cell.audioLabel.isHidden = true
        } else {
            cell.audioLabel.isHidden = false
            //cell.audioLabel.tintColor = UIColor.red
        }
        
        if task.important {
            cell.importantLabel.isHidden = false
            cell.cellTitle.text = "\(task.taskName!)"
            cell.cellText.text = task.taskNotes!
           
            
        } else {
            cell.importantLabel.isHidden = true
            cell.cellTitle.text = "\(task.taskName!)"
            cell.cellText.text = task.taskNotes!
        }
        
        cell.priorityLabel.text = "\(task.taskPriority+1)"
        //cell.priorityLabel.isHidden = false
        
        
        if sortSelection == 0 {
            
            cell.dueDateLabel.isHidden = true
            cell.createdDateLabel.isHidden = true
            cell.priorityLabel.isHidden = false
            
            
        }else if sortSelection == 1 {
            cell.dueDateLabel.isHidden = false
            cell.createdDateLabel.isHidden = true
            cell.priorityLabel.isHidden = true
        }else if sortSelection == 2 {
            cell.dueDateLabel.isHidden = true
            cell.createdDateLabel.isHidden = false
            cell.priorityLabel.isHidden = true
            
            let numOfDaysSinceCreate: Int = daysBetweenDates(startDate: startOfCreated as! Date, endDate: Date())
            
            
            if numOfDaysSinceCreate == 1 {
                cell.createdDateLabel.text = "\(numOfDaysSinceCreate) day old"
                cell.createdDateLabel.textColor = UIColor.lightGray
            } else if numOfDaysSinceCreate == 0 {
                cell.createdDateLabel.text = "NEW"
                cell.createdDateLabel.textColor = UIColor.blue
            }else{
                cell.createdDateLabel.text = "\(numOfDaysSinceCreate) days old"
                cell.createdDateLabel.textColor = UIColor.lightGray
            }
            
            
        } else {
            cell.dueDateLabel.isHidden = true
            cell.createdDateLabel.isHidden = true
            cell.priorityLabel.isHidden = true
        }
        
        
        
        
//        if(tasks[0] != nil) {
//            let defaults: UserDefaults = UserDefaults(suiteName: "group.DoIts.Widget")!
//            let symbolAndprize = "HI!"
//            defaults.set( symbolAndprize , forKey: "TaskToday")
//        }

        
        
        
        return (cell)
        
    }
    
    

    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if tableView.isEditing == true {
        } else {
        
        let task = tasks[indexPath.row]
            maskView.isHidden = false
        
        
        performSegue(withIdentifier: "addSegue", sender: task)
            //print("The due date is \(task.dueDate)")
            editsButton.isEnabled = false
           // categoriesButton.isEnabled = false
            filterButton.isEnabled = false
            addButton.isEnabled = false
            
        
        
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editMode()
    }
    
    

    @IBAction func pageSwiped(_ sender: UISwipeGestureRecognizer) {
        
        performSegue(withIdentifier: "addSegue", sender: AnyObject.self)
        
        editsButton.isEnabled = false
        //categoriesButton.isEnabled = false
        filterButton.isEnabled = false
    addButton.isEnabled = false
         maskView.isHidden = false
        
    }
    
    
    @IBAction func pageSwipedTwo(_ sender: UISwipeGestureRecognizer) {
        
        performSegue(withIdentifier: "addSegue", sender: AnyObject.self)
        
        editsButton.isEnabled = false
        //categoriesButton.isEnabled = false
        filterButton.isEnabled = false
        addButton.isEnabled = false
        maskView.isHidden = false
        
    }
    
    
    @IBAction func pageSwipedThree(_ sender: UISwipeGestureRecognizer) {
        
        performSegue(withIdentifier: "addSegue", sender: AnyObject.self)
        
        editsButton.isEnabled = false
        //categoriesButton.isEnabled = false
        filterButton.isEnabled = false
        addButton.isEnabled = false
        maskView.isHidden = false
        
    }
   
   
  
  

  
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
       
        
        
        if sortSelection == 0 {
            return true
        }
        else {
            return false
        }
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var itemToMove = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(itemToMove, at: destinationIndexPath.row)
        let firstTask = IndexPath(row: 0, section: 0)
        let lastTask = IndexPath(row:(tasks.count)-1, section: 0)
        prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
        tableView.reloadData()
        
    }
    
    func prioritizeTasks ( firstTask: IndexPath, lastTask: IndexPath) {
        
        for index in firstTask.row...lastTask.row {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let task = tasks[index]
                task.taskPriority = Int64(index)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
            }
        print (tasks)
        
    }
    
    func getCompletedTasks () {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let entity = NSEntityDescription.entity(
    forEntityName: "Task", in: context)
    let request: NSFetchRequest<Task> = Task.fetchRequest()
    request.entity = entity
    let pred = NSPredicate(format: "(completed == %@)", true as CVarArg)
    request.predicate = pred
    do{
    completedTasks = try context.fetch(request as!
    NSFetchRequest<NSFetchRequestResult>) as! [Task]
    } catch {}

    
    
    
    }

    
    func getCategories () {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            categories = try context.fetch(Category.fetchRequest())
        } catch {
        }
    }

    
    
//    func getTasks () {
//        
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(
//            forEntityName: "Task", in: context)
//        let request: NSFetchRequest<Task> = Task.fetchRequest()
//        request.entity = entity
//        let pred = NSPredicate(format: "(completed == %@)", false as CVarArg)
//        request.predicate = pred
//        do{
//            tasks = try context.fetch(request as!
//                NSFetchRequest<NSFetchRequestResult>) as! [Task]
//        } catch {}
//        
//        
//       
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        if segue.identifier == "addItem" {
//            
//            let popoverViewController = segue.destination
//            popoverViewController.popoverPresentationController?.delegate = self
//            let vc = segue.destination as? AddItemViewController
//            let pop = vc?.popoverPresentationController
//            pop?.delegate = vc as! UIPopoverPresentationControllerDelegate?
//            
//        }
        
        if segue.identifier == "showCategories" {
        let nextVC = segue.destination as! CategoriesViewController
        nextVC.category = sender as? Category
        }

        
        
        
//        if segue.identifier == "selectTaskSegue" {
//            let nextVC = segue.destination as! CompleteTaskViewController
//            nextVC.task = sender as? Task
//                   }
        
        if segue.identifier == "addSegue" {
            
            let nextVC = segue.destination as! CreateTaskViewController
            nextVC.task = sender as? Task
            nextVC.selectedCategory = category
            
            
        }
        
        if segue.identifier == "popover" {
            let vc = segue.destination as? FiltersViewController
            let pop = vc?.popoverPresentationController
            pop?.delegate = vc
            let nextVC = segue.destination as! FiltersViewController
            nextVC.filterSelections = filterSelections
            //nextVC.sortSelection = sortSelection
        }
        
        if segue.identifier == "showSort" {
            let nextVC = segue.destination as! SortViewController
            
            nextVC.sortSelection = sortSelection
        }
        
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       
        
        
        
        var didItRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Did it ✓",  handler:{action, indexpath in
            print("DELETE•ACTION");
            
            
            
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let task = self.tasks[indexPath.row]
            
            task.completed = true
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
           // self.getTasks()
            self.startUpProcedures()
            //self.getCompletedTasks()
            //tableView.reloadData()
//            self.taskCount()
//            self.noTasks()
//            self.showCompletedTaskLabel()
            
            
            //self.determineSortOrder()
//            self.tasks.sort(by: {
//                $0.taskPriority < $1.taskPriority
//            })
            
//            if self.tasks.count > 0 {
//            let firstTask = IndexPath(row: 0, section: 0)
//            let lastTask = IndexPath(row:(self.tasks.count)-1, section: 0)
//            
//            self.prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
//            
//            
//            }
        });
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Remove x", handler:{action, indexpath in
            print("DELETE•ACTION");
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            
            let task = self.tasks[indexPath.row]
            
            context.delete(task)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            self.startUpProcedures()
            
        });

        
        
    didItRowAction.backgroundColor = UIColor(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
    
        
        return [deleteRowAction, didItRowAction];
    }
    
   
    func taskCount () {
        
//        if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false {
        if tasks.count > 1 {
            taskNumber.isHidden = false
        taskNumber.text = "\(tasks.count) more tasks remaining"
            taskNumber.textColor = UIColor.black
            editsButton.isEnabled = true
        }
        
        else if tasks.count == 1{
            taskNumber.isHidden = false
            taskNumber.text = "Only 1 task left!"
            taskNumber.textColor = UIColor.black
            editsButton.isEnabled = true
        }
       else {
            taskNumber.isHidden = true
            editsButton.isEnabled = false
           
        }
//        }else {
//            print ("I have a filter")
//        }
    }
    
    func editMode() {
        if tableView.isEditing == true {
            tableView.isEditing = false
            editsButton.title = "Edit"
            editsButton.tintColor = UIColor.black
            didEmButton.isEnabled = false
            filterButton.isEnabled = true
            addButton.isEnabled = true
            removeButton.isEnabled = false
            removeButton.tintColor = UIColor.clear
            taskNumber.isHidden = false
           // categoriesButton.isEnabled = true
            didEmButton.tintColor = UIColor.clear
            completedButton.isEnabled = true
            //sortNameLabel.isHidden = false
            if completedTasks.count > 0 {
            completedTasksButtonView.isHidden = false
            }
                } else {
            removeButton.isEnabled = true
            removeButton.tintColor = UIColor.red
            tableView.isEditing = true
            editsButton.title = "Cancel"
            editsButton.tintColor = UIColor.black
            didEmButton.isEnabled = true
            filterButton.isEnabled = false
            addButton.isEnabled = false
            taskNumber.isHidden = true
            //sortNameLabel.isHidden = true
           // categoriesButton.isEnabled = false
            didEmButton.tintColor = UIColor(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
            completedButton.isEnabled = false
            if completedTasks.count > 0 {
                completedTasksButtonView.isHidden = true
            }
        }
    }
    
    func showCompletedTaskLabel () {
        
        if completedTasks.count == 0 {
           completedTasksButtonView.isHidden = true
            completedButton.isEnabled = false
            completedButton.isHidden = true
            
            completedNumberLabel.isHidden = true
        } else {
            completedTasksButtonView.isHidden = false
            completedButton.isHidden = false
            completedButton.isEnabled = true
            completedNumberLabel.isHidden = false
            completedNumberLabel.text = "\(completedTasks.count)"
        }
        
    }
    
    @IBAction func unwindToListFromAddList(segue: UIStoryboardSegue) {
        startUpProcedures()
    }
    
    
    @IBAction func unwindToListFromAddTask(segue: UIStoryboardSegue) {
        startUpProcedures()
    }
    

    
    
    @IBAction func unwindToSelectedCategory(segue: UIStoryboardSegue ) {
        
        
        maskView.isHidden = true
        //saveSelectedCategory()
        print (category?.categoryName)
        startUpProcedures()
//        getTasksForCategory()
//        getCompletedTasks()
//        noTasks()
//        showCompletedTaskLabel()
//        tableView.reloadData()
        //categoriesButton.isEnabled = true
//        tasks.sort(by: {
//            $0.taskPriority < $1.taskPriority
//        })
        
//        determineSortOrder()
//        taskCount()
       // categoryNameLabel.text = "Category: \(category!.categoryName!)"
//        if tasks.count > 0 {
//            let firstTask = IndexPath(row: 0, section: 0)
//            let lastTask = IndexPath(row:(tasks.count)-1, section: 0)
//            
//            prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
//        }

        
    }
    
    
    @IBAction func unwindToTasksWithSort(segue: UIStoryboardSegue ) {
        
        startUpProcedures()
        
       
        
    }
    
    
    @IBAction func unwindToTasksWithFilter(segue: UIStoryboardSegue ) {
        
      startUpProcedures()
        

        
    }
    
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
    
    let selectedCategoryName = category?.categoryName
    

    //no filter/categories- show all tasks
    if category != nil && filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false {
        let pred = NSPredicate(format: "(completed == %@)", false as CVarArg)
        let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
        let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [pred,predCat])

        request.predicate = predicateCompound
        do{
            tasks = try context.fetch(request as!
                NSFetchRequest<NSFetchRequestResult>) as! [Task]
            
            taskCount()
            
            print("helo")
            
            print (tasks)
            
            filterLabel.text = "Show All"
            filterLabel.textColor = UIColor.black
            
        } catch {}
    }
    
    
    //no filter/no categories - show all tasks
    if category == nil && filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false{
        let pred = NSPredicate(format: "(completed == %@)", false as CVarArg)
        
        request.predicate = pred
        do{
            tasks = try context.fetch(request as!
                NSFetchRequest<NSFetchRequestResult>) as! [Task]
            
            taskCount()
            
            filterLabel.text = "Show All"
            filterLabel.textColor = UIColor.black
        } catch {}
    }
    
    //show only important tasks
    if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false {
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
            
            filterLabel.text = "Urgent"
            filterLabel.textColor = UIColor.red
        } catch {}

    }
    
    //show todays tasks only
    if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false {
    
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
            
            filterLabel.text = "Due Today"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    //show only this weeks tasks
    if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false {
        
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
            
            filterLabel.text = "Due this week"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    //show only past due tasks
    if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false {
        
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
            
            filterLabel.text = "Past Due"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    //show past due and important tasks
    if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false {
        
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
            
            filterLabel.text = "Past Due, Urgent"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    //show this weeks,todays that are important
    if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false {
        
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
            filterLabel.text = "Due this week, Urgent"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    //show todays that are important
    if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == false {
        
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
            filterLabel.text = "Due today, Urgent"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    //show past due + this week + today that are important
    if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false {
        
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
            filterLabel.text = "Past Due, Due this week, Urgent"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    //show past due + today that are important
    if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == false {
        
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
            filterLabel.text = "Past Due, Due today, Urgent"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    //show past due + week + today
    if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false {
        
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
            filterLabel.text = "Past Due, Due this week"
            filterLabel.textColor = UIColor.red
        } catch {}

    }

    //show today + past due
    if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == false {
        
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
            filterLabel.text = "Past Due, Due today"
            filterLabel.textColor = UIColor.red
        } catch {}
        
    }
    
    //show past due + today that are important & audio
    if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true {
        
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
            filterLabel.text = "Past Due, Due today, Urgent, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    
    
    
    //show past due + today & audio
    if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true {
        
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
            filterLabel.text = "Past Due, Due today, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    
    
    //show past due that are important & audio
    if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true {
        
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
            filterLabel.text = "Past Due, Important, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    
    
    //show past due & audio
    if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true {
        
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
            filterLabel.text = "Past Due, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }


    
    //show due today that are important & audio
    if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == true {
        
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
            filterLabel.text = "Due today, Urgent, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    
    
    //show due today & audio
    if filterSelections[0] == true && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true {
        
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
            filterLabel.text = "Due today, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    
    
    //show due this week that are important & audio
    if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == true && filterSelections[4] == true {
        
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
            filterLabel.text = "Due this week, Urgent, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    
    //show due this week & audio
    if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true {
        
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
            filterLabel.text = "Due this week, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    
    
    //show past due, due this week that are important & audio
    if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == true && filterSelections[4] == true {
        
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
            filterLabel.text = "Past due, Due this week, Urgent, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    //show past due, due this week & audio
    if filterSelections[0] == true && filterSelections[1] == true && filterSelections[2] == true && filterSelections[3] == false && filterSelections[4] == true {
        
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
            filterLabel.text = "Past due, Due this week, audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }
    
    
    
    //show  audio
    if filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == true {
        
        
        
        
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
            filterLabel.text = "Audio"
            filterLabel.textColor = UIColor.red
        } catch {}
    }

    





    
     if (filterSelections[0] == false && filterSelections[1] == false && filterSelections[2] == false && filterSelections[3] == false && filterSelections[4] == false) != true {
        
       
        
        
        
        filterView.backgroundColor = UIColor(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
        
         filterLabel.textColor = UIColor.white
        
        filterLabel.layer.borderColor = UIColor.white.cgColor
        
       
        
        filterImage.image = filterImage.image!.withRenderingMode(.alwaysTemplate)
        filterImage.tintColor = UIColor.white
        
        filterExpand.image = filterExpand.image!.withRenderingMode(.alwaysTemplate)
        filterExpand.tintColor = UIColor.white
          
        
     }else {
        
        filterView.backgroundColor = UIColor.white
        
         filterLabel.textColor = UIColor.black
        
        filterLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        filterImage.tintColor = UIColor.black
        
        filterExpand.tintColor = UIColor.black
        
        filterImage.image = filterImage.image!.withRenderingMode(.alwaysTemplate)
        filterImage.tintColor = UIColor.black
        
        filterExpand.image = filterExpand.image!.withRenderingMode(.alwaysTemplate)
        filterExpand.tintColor = UIColor.black
        
    }
    
    }

    
    func determineSortOrder() {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "protoCell") as! taskTableViewCell
        
        if sortSelection == 0 {
            self.tasks.sort(by: {
                $0.taskPriority < $1.taskPriority
            })
        
            
            if self.tasks.count > 0 {
            let firstTask = IndexPath(row: 0, section: 0)
            let lastTask = IndexPath(row:(tasks.count)-1, section: 0)
            prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
                
               
            
//            cell.dueDateLabel.isHidden = true
//                cell.createdDateLabel.isHidden = true
//                cell.priorityLabel.isHidden = false
            }
            sortLabel.text = "Priority"
        }
        
        if sortSelection == 1 {
            tasks.sort(by: {(($0.dueDate?.timeIntervalSinceNow)!) < (($1.dueDate?.timeIntervalSinceNow)!)})
            
            sortLabel.text = "Due Date"
            
//            cell.dueDateLabel.isHidden = false
//            cell.priorityLabel.isHidden = true
//            cell.createdDateLabel.isHidden = true
//            print(tasks)
        }

        if sortSelection == 2 {
            tasks.sort(by: {Double(($0.createdDate?.timeIntervalSinceNow)!) > Double(($1.createdDate?.timeIntervalSinceNow)!)})
//            cell.priorityLabel.isHidden = true
//            cell.createdDateLabel.isHidden = false
//            cell.dueDateLabel.isHidden = true
            sortLabel.text = "Created Date"
        }
        
        if sortSelection == 3 {
            self.tasks.sort(by: {
                $0.taskName! < $1.taskName!
            })
            sortLabel.text = "Task Name"
        }
        
        
        if sortSelection != 3 {
            
            
            
            
            
            sortView.backgroundColor = UIColor(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
            
            sortLabel.textColor = UIColor.white
            
            sortLabel.layer.borderColor = UIColor.white.cgColor
            
            
            
            sortImage.image = sortImage.image!.withRenderingMode(.alwaysTemplate)
            sortImage.tintColor = UIColor.white
            
            sortExpand.image = sortExpand.image!.withRenderingMode(.alwaysTemplate)
            sortExpand.tintColor = UIColor.white
            
            
        }else {
            
            sortView.backgroundColor = UIColor.white
            
            sortLabel.textColor = UIColor.black
            
            sortLabel.layer.borderColor = UIColor.lightGray.cgColor
            
            sortImage.tintColor = UIColor.black
            
            sortExpand.tintColor = UIColor.black
            
            sortImage.image = sortImage.image!.withRenderingMode(.alwaysTemplate)
            sortImage.tintColor = UIColor.black
            
            sortExpand.image = sortExpand.image!.withRenderingMode(.alwaysTemplate)
            sortExpand.tintColor = UIColor.black
            
        }

        
        
    }
    
    
   
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue ) {
        
    
        maskView.isHidden = true
        startUpProcedures()
//        getTasks()
//        getCompletedTasks()
//        noTasks()
//        showCompletedTaskLabel()
//        taskCount()
//        tableView.reloadData()
        //categoriesButton.isEnabled = true
        //filterButton.isEnabled = true
        addButton.isEnabled = true
//        tasks.sort(by: {
//            $0.taskPriority < $1.taskPriority
//        })
        
      //  determineSortOrder()
        
//        if tasks.count > 0 {
//            let firstTask = IndexPath(row: 0, section: 0)
//            let lastTask = IndexPath(row:(tasks.count)-1, section: 0)
//            
//            prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
//        }

    }
    
    
    
    
    @IBAction func unwindToTasks(segue: UIStoryboardSegue ) {
        
        maskView.isHidden = true
        startUpProcedures()
//        getTasks()
//        getCompletedTasks()
//        noTasks()
//        showCompletedTaskLabel()
//        taskCount()
//        tableView.reloadData()
//        tasks.sort(by: {
//            $0.taskPriority < $1.taskPriority
//        })
//        
//        if tasks.count > 0 {
//            let firstTask = IndexPath(row: 0, section: 0)
//            let lastTask = IndexPath(row:(tasks.count)-1, section: 0)
//            
//            prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
//        }
//        
 //       maskView.isHidden = true
        
    }

    
    
    
    func noTasks() {
    
    if tasks.count == 0 {
    tableView.isHidden = true
        editsButton.isEnabled = false
        noTasksLabel.isHidden = false
        dragMessage.isHidden = false
       // filterButton.isEnabled = false
        addButton.isEnabled = true
        dragToCreateView.isHidden = false
        //sortNameLabel.isHidden = true
    
    }else {
        tableView.isHidden = false
        editsButton.isEnabled = true
        noTasksLabel.isHidden = true
        dragMessage.isHidden = true
        //filterButton.isEnabled = true
        addButton.isEnabled = true
        dragToCreateView.isHidden = true
        //sortNameLabel.isHidden = false
        
        }
    
    }
    
    
   
    
    
//    @IBAction func categoryButtonTapped(_ sender: Any) {
//        
//        performSegue(withIdentifier: "showCategories", sender: self)
//        maskView.isHidden = false
//        editsButton.isEnabled = false
//        filterButton.isEnabled = false
//        
//        
//    }
    
//    @IBAction func pageSwipedToCategories(_ sender: UISwipeGestureRecognizer) {
//        performSegue(withIdentifier: "showCategories", sender: category)
//        maskView.isHidden = false
//        editsButton.isEnabled = false
//        filterButton.isEnabled = false
//        addButton.isEnabled = false
//
//    }
//    
    
    @IBAction func listDragViewSwiped(_ sender: UISwipeGestureRecognizer) {
        
        performSegue(withIdentifier: "showCategories", sender: category)
        maskView.isHidden = false
        editsButton.isEnabled = false
        filterButton.isEnabled = false
        addButton.isEnabled = false
    }
    
    @IBAction func listDragViewTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "showCategories", sender: category)
        maskView.isHidden = false
        editsButton.isEnabled = false
        filterButton.isEnabled = false
        addButton.isEnabled = false
    }
    
    
    
//    @IBAction func pageSwipedToCategoriesTwo(_ sender: UISwipeGestureRecognizer) {
//            performSegue(withIdentifier: "showCategories", sender: category)
//            maskView.isHidden = false
//            editsButton.isEnabled = false
//            filterButton.isEnabled = false
//        addButton.isEnabled = false
//    }
    
    
    
    @IBAction func removeButtonTapped(_ sender: Any) {
        
        
        if let indexPaths = tableView.indexPathsForSelectedRows as! [IndexPath]! {
            for indexPath in indexPaths {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let task = self.tasks[indexPath.row]
                
                context.delete(task)
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            
            self.startUpProcedures()
            
            if self.tasks.count > 0 {
                let firstTask = IndexPath(row: 0, section: 0)
                let lastTask = IndexPath(row:(self.tasks.count)-1, section: 0)
                
                self.prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
                
                
            }
            
            tableView.isEditing = false
            editsButton.title = "Edit"
            editsButton.tintColor = UIColor.black
            didEmButton.isEnabled = false
            didEmButton.tintColor = UIColor.clear
            completedButton.isEnabled = true
            removeButton.isEnabled = false
            removeButton.tintColor = UIColor.clear
            
            
            
            
            
            
        }


        
    }
    
    

    
    @IBAction func didEmButtonTapped(_ sender: Any) {
       
        if let indexPaths = tableView.indexPathsForSelectedRows as! [IndexPath]! {
            for indexPath in indexPaths {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let task = self.tasks[indexPath.row]
                
                task.completed = true
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
           
            self.startUpProcedures()
            
//            self.getTasks()
//            self.getCompletedTasks()
//            self.taskCount()
//            self.noTasks()
//            self.taskCount()
//            self.showCompletedTaskLabel()
//            
//            tableView.reloadData()
            
//            self.tasks.sort(by: {
//                $0.taskPriority < $1.taskPriority
//            })
            
           // determineSortOrder()
            
            if self.tasks.count > 0 {
                let firstTask = IndexPath(row: 0, section: 0)
                let lastTask = IndexPath(row:(self.tasks.count)-1, section: 0)
                
                self.prioritizeTasks(firstTask: firstTask, lastTask: lastTask)
                
                
            }
            
            tableView.isEditing = false
            editsButton.title = "Edit"
            editsButton.tintColor = UIColor.black
            didEmButton.isEnabled = false
            didEmButton.tintColor = UIColor.clear
            completedButton.isEnabled = true
            removeButton.tintColor = UIColor.clear
            removeButton.isEnabled = false

        
        
        
        }


}
    
//    func getTasksForCategory() {
//    
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    let entity = NSEntityDescription.entity(
//    forEntityName: "Task", in: context)
//    let request: NSFetchRequest<Task> = Task.fetchRequest()
//    request.entity = entity
//    let selectedCategoryName = category!.categoryName
//    let predCat = NSPredicate(format: "%K = %@", "taskCategory.categoryName", (selectedCategoryName)!)
//    let pred2 = NSPredicate(format: "(completed == %@)", false as CVarArg)
//    let predicateCompound = NSCompoundPredicate.init(type: .and, subpredicates: [predCat, pred2])
//    request.predicate = predicateCompound
//    do{
//    tasks = try context.fetch(request as!
//    NSFetchRequest<NSFetchRequestResult>) as! [Task]
//    } catch {}
//    
//    }
    
    
    @IBAction func addItemButtonTapped(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "addItem", sender: self)
        
        performSegue(withIdentifier: "addSegue", sender: [category, self])
        
        maskView.isHidden = false
      
    }
    
    func displayCategoryName () {
        if category?.categoryName != "Misc" {
            self.navigationItem.title = "to\(category!.categoryName!)do"
        }else {
            self.navigationItem.title = "toListdo"
        }
    }
    
    
   
    @IBAction func filterButtonTapped(_ sender: Any) {
        
         performSegue(withIdentifier: "popover", sender: filterSelections)
         maskView.isHidden = false
        
    }
    
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "showSort", sender: [filterSelections, sortSelection])
        maskView.isHidden = false
    }
    
    
    
    
 

//    @IBAction func filterButtonTapped(_ sender: Any) {
//        performSegue(withIdentifier: "popover", sender: [filterSelections, sortSelection])
//       // maskView.isHidden = false
//    }
    
//    func getSelectedCategory() {
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do{
//            category = try context.fetch(SelectedCategory.fetchRequest())
//        } catch {
//        }
//
//               
//    }
//    
//    func saveSelectedCategory() {
//        
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        
//        let selectedCategory = SelectedCategory(context: context)
//        
//        self.selectedCategory.category = category
//        
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//
//        
//        
//    }
    
    
    func startUpProcedures () {
        
        maskView.isHidden = true
        filterButton.isEnabled = true
        //autoGoToTask()
        getTasksDueToday()
        getCategories()
       // getSelectedCategory()
       
        
        if category != nil {
            
            determineFilters()
            getCompletedTasks()
            noTasks()
            tableView.reloadData()
            taskCount()
            determineSortOrder()
            showCompletedTaskLabel()
            displayCategoryName()
            
        }
        
//else {
//
//            determineFilters()
//            getCompletedTasks()
//            noTasks()
//            tableView.reloadData()
//            taskCount()
//            determineSortOrder()
//            showCompletedTaskLabel()
//            displayCategoryName()
//            
//            
//            
//        }
        
        
        
    }
    
//    func determineTasks () {
//    if tasks.count == 0 {
//    tableView.isHidden = true
//    filterButton.isEnabled = false
//    editsButton.isEnabled = false
//    taskNumber.isHidden = true
//    }else {
//        print ("I have tasks!")
//        }
//    }
    
        
    



}
