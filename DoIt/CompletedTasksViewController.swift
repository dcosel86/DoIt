//
//  CompletedTasksViewController.swift
//  DoIt
//
//  Created by Amanda Cosel on 2/17/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import CoreData

class CompletedTasksViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editsButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBOutlet weak var putBackButton: UIToolbar!
    
    var completedTasks : [Task] = []
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editMode()
    }
   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
       
        
        self.navigationController?.isNavigationBarHidden = false

        
        self.tableView.allowsMultipleSelectionDuringEditing = true
        editsButton.tintColor = UIColor.black
        
        deleteButton.isEnabled = false
        deleteButton.tintColor = UIColor.clear
        
        putBackButton.tintColor = UIColor.clear
        
        
//        UINavigationBar.appearance().barTintColor = UIColor(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
        //
        //
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCompletedTasks()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (completedTasks.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "compProtoCell") as! CompletedTasksTableViewCell
        let completedTask = completedTasks[indexPath.row]
        cell.completedTaskNameLabel.text = completedTask.taskName
        cell.completedTaskTextLabel.text = completedTask.taskNotes
        
        
        return (cell)
        


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
    
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Put Back", handler:{action, indexpath in
            print("MORE•ACTION");
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let completedTask = self.completedTasks[indexPath.row]
            
            completedTask.completed = false
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            self.getCompletedTasks()
            tableView.reloadData()
            self.navigationController!.popViewController(animated: true)
            
            
            
            
        });
        moreRowAction.backgroundColor = UIColor(colorLiteralRed: 51/200, green: 90/255, blue:
            149/255, alpha: 1);
        
        var deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete", handler:{action, indexpath in
            print("DELETE•ACTION");
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let completedTask = self.completedTasks[indexPath.row]
            
            context.delete(completedTask)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            self.getCompletedTasks()
            tableView.reloadData()
            
            if self.completedTasks.count == 0 {
                self.navigationController!.popViewController(animated: true)
            }
        
            
        });
        
        return [deleteRowAction, moreRowAction];
    }
    
    func editMode() {
        if tableView.isEditing == true {
            tableView.isEditing = false
            editsButton.title = "Edit"
            editsButton.tintColor = UIColor.black
            deleteButton.isEnabled = false
            deleteButton.tintColor = UIColor.clear
            putBackButton.tintColor = UIColor.clear
        } else {
            tableView.isEditing = true
            editsButton.title = "Cancel"
            editsButton.tintColor = UIColor.black
            deleteButton.isEnabled = true
            deleteButton.tintColor = UIColor.black
            putBackButton.tintColor = UIColor.black
            
                        
        }
    }
    
    
    
    @IBAction func putBackButtonTapped(_ sender: Any) {
        
        if let indexPaths = tableView.indexPathsForSelectedRows as! [IndexPath]! {
            for indexPath in indexPaths {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let task = self.completedTasks[indexPath.row]
                
                task.completed = false
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            
            self.getCompletedTasks()
            tableView.reloadData()
            
            
            tableView.isEditing = false
            putBackButton.isHidden = true
            editsButton.title = "Edit"
            editsButton.tintColor = UIColor.black
            deleteButton.isEnabled = false
            deleteButton.tintColor = UIColor.clear
            self.getCompletedTasks()
            tableView.reloadData()
            
            self.navigationController!.popViewController(animated: true)
            
            
            
            
        }

    }
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        
        if let indexPaths = tableView.indexPathsForSelectedRows as! [IndexPath]! {
            for indexPath in indexPaths {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let task = self.completedTasks[indexPath.row]
                
                context.delete(task)
                
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            
            self.getCompletedTasks()
            tableView.reloadData()
           
            
            tableView.isEditing = false
            editsButton.title = "Edit"
            editsButton.tintColor = UIColor.black
            deleteButton.isEnabled = false
            deleteButton.tintColor = UIColor.clear
            self.getCompletedTasks()
            tableView.reloadData()
            
                self.navigationController!.popViewController(animated: true)

            
            
            
        }

    }


}
