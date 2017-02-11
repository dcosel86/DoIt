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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addTask(_ sender: Any) {
        //create new task
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        
        
        
        task.taskName = taskNameTextField.text!
        task.important = importantSwitch.isOn
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        
        //pop back
       
        
      
       
        navigationController!.popViewController(animated: true)
        
    }

}
