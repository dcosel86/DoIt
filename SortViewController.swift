//
//  SortViewController.swift
//  DoIts
//
//  Created by Amanda Cosel on 3/27/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import CoreData

class SortViewController: UIViewController {
    
    
    //outlets
    
    
    @IBOutlet weak var sortView: UIView!
    
    @IBOutlet weak var taskNameSwitch: UISwitch!
    
    @IBOutlet weak var prioritySwitch: UISwitch!
    
    @IBOutlet weak var dueDateSwitch: UISwitch!
    
    @IBOutlet weak var createdDateSwitch: UISwitch!
    
    @IBOutlet weak var applyButton: UIBarButtonItem!
    
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    
    var sortSelection : Int? = 3

    override func viewDidLoad() {
        super.viewDidLoad()

       // applyButton.title = "Cancel"
        
        sortSelection = sorting?.sortSelection
        
        sortView.layer.cornerRadius = 5
        
        UINavigationBar.appearance().barTintColor = UIColor.white
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
    
    determineSortState()
        
        applyButton.title = "Cancel"
        
        if sortSelection != 3 {
            resetButton.isEnabled = true
        }else {
            resetButton.isEnabled = false
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let nextVC = segue.destination as! TasksViewController
//        nextVC.sortSelection = sortSelection
        
        
    }

  
//    func defaultSortState() {
//        taskNameSwitch.isOn = true
//        prioritySwitch.isOn = false
//        dueDateSwitch.isOn = false
//        createdDateSwitch.isOn = false
//        
//    }
    
    func determineSortState() {
        if sortSelection == 0 {
            taskNameSwitch.isOn = false
            prioritySwitch.isOn = true
            dueDateSwitch.isOn = false
            createdDateSwitch.isOn = false
            resetButton.isEnabled = true
           // prioritySwitch.isEnabled = false
        }
        
        if sortSelection == 1 {
            taskNameSwitch.isOn = false
            prioritySwitch.isOn = false
            dueDateSwitch.isOn = true
            createdDateSwitch.isOn = false
            resetButton.isEnabled = true
           // dueDateSwitch.isEnabled = false
        }
        if sortSelection == 2{
            taskNameSwitch.isOn = false
            prioritySwitch.isOn = false
            dueDateSwitch.isOn = false
            createdDateSwitch.isOn = true
            resetButton.isEnabled = true
            //createdDateSwitch.isEnabled = false
        }
        if sortSelection == 3 {
            taskNameSwitch.isOn = true
            prioritySwitch.isOn = false
            dueDateSwitch.isOn = false
            createdDateSwitch.isOn = false
            resetButton.isEnabled = false
           // taskNameSwitch.isEnabled = false
        }
    }
    
    
    
    @IBAction func taskSwitchTapped(_ sender: Any) {
        if taskNameSwitch.isOn == true {
            sortSelection = 3
            sorting?.sortSelection = sortSelection!
            determineSortState()
            applyButton.title = "Apply"
//            taskNameSwitch.isEnabled = false
//            prioritySwitch.isEnabled = true
//            dueDateSwitch.isEnabled = true
//            createdDateSwitch.isEnabled = true
        } else {
            taskNameSwitch.isOn = true
        
        }
        
        
    }
    
    @IBAction func prioritySwitchTapped(_ sender: Any) {
        if prioritySwitch.isOn == true {
            sortSelection = 0
            sorting?.sortSelection = sortSelection!
            determineSortState()
            applyButton.title = "Apply"
//            taskNameSwitch.isEnabled = true
//            prioritySwitch.isEnabled = false
//            dueDateSwitch.isEnabled = true
//            createdDateSwitch.isEnabled = true
        } else {
            prioritySwitch.isOn = true
        }
    }
    
    
    @IBAction func dueDateSwitchTapped(_ sender: Any) {
        if dueDateSwitch.isOn == true {
            sortSelection = 1
            sorting?.sortSelection = sortSelection!
            determineSortState()
            applyButton.title = "Apply"
//            taskNameSwitch.isEnabled = true
//            prioritySwitch.isEnabled = true
//            dueDateSwitch.isEnabled = false
//            createdDateSwitch.isEnabled = true
        } else {
            dueDateSwitch.isOn = true
        }
    }
    
    
    
    @IBAction func createdDateSwitchTapped(_ sender: Any) {
        if createdDateSwitch.isOn == true {
            sortSelection = 2
            sorting?.sortSelection = sortSelection!
            determineSortState()
            applyButton.title = "Apply"
//            taskNameSwitch.isEnabled = true
//            prioritySwitch.isEnabled = true
//            dueDateSwitch.isEnabled = true
//            createdDateSwitch.isEnabled = false
        } else {
            createdDateSwitch.isOn = true
        }
    }
    
    
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        
        sortSelection = 3
        sorting?.sortSelection = sortSelection!
        determineSortState()
//        taskNameSwitch.isEnabled = false
//        prioritySwitch.isEnabled = true
//        dueDateSwitch.isEnabled = true
//        createdDateSwitch.isEnabled = true
        applyButton.title = "Apply"
    }
    
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        sorting?.determineSortLabels()
         performSegue(withIdentifier: "unwindToTasksWithSort", sender: self)
        NotificationCenter.default.post(name: .reload, object: nil)
        UINavigationBar.appearance().barTintColor = UIColor.darkGray
        
       
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor.white

    }



}
