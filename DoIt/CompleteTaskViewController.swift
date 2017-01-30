//
//  CompleteTaskViewController.swift
//  DoIt
//
//  Created by Amanda Cosel on 1/29/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit

class CompleteTaskViewController: UIViewController {
    
    
    @IBOutlet weak var taskName: UILabel!
    
    @IBAction func taskCompleted(_ sender: Any) {
        previousVC.tasks.remove(at: previousVC.selectedIndex)
        previousVC.tableView.reloadData()
        navigationController!.popViewController(animated: true)
    }
    
    var task = Task()
    var previousVC = TasksViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if task.important {
            taskName.text = "❗️\(task.taskName)"
        }else {
            taskName.text = task.taskName
        }
        
        

        // Do any additional setup after loading the view.
    }

}
