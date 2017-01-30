//
//  CreateTaskViewController.swift
//  DoIt
//
//  Created by Amanda Cosel on 1/29/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    @IBOutlet weak var importantSwitch: UISwitch!
    
    var previousVC = TasksViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addTask(_ sender: Any) {
        //create new task
        let task = Task()
        task.taskName = taskNameTextField.text!
        task.important = importantSwitch.isOn
        
        
        
        
        //add task to array
        previousVC.tasks.append(task)
        
        print(previousVC.tasks.count)
        previousVC.tableView.reloadData()
        navigationController!.popViewController(animated: true)
        
    }

}
