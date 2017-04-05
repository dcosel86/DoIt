//
//  FiltersViewController.swift
//  DoIt
//
//  Created by Amanda Cosel on 2/28/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import CoreData

class FiltersViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    //outlets
    @IBOutlet weak var dueTodaySwitch: UISwitch!
    
    @IBOutlet weak var dueThisWeekSwitch: UISwitch!
    
    @IBOutlet weak var isImportantSwitch: UISwitch!
    
    //@IBOutlet weak var sortControl: UISegmentedControl!
    
    @IBOutlet weak var applyButton: UIBarButtonItem!
    
    @IBOutlet weak var resetButton: UIBarButtonItem!

    @IBOutlet weak var pastDueSwitch: UISwitch!
    
    @IBOutlet weak var audioSwitch: UISwitch!
    
    @IBOutlet weak var filterView: UIView!
    
    
    
    // 0:today 1:week 2:past 3:imp 4:audio
    var filterSelections : [Bool] = [false, false, false, false, false]
    //1:priority 2:duedate 3:created
    //var sortSelection : Int? = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        determineFilterSelections()
        
        applyButton.title = "Cancel"
     
         filterView.layer.cornerRadius = 5
        
       UINavigationBar.appearance().barTintColor = UIColor.white
        //
        //
        
        
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        
        if filterSelections[1] == true {
            dueTodaySwitch.isEnabled = false
        }
        
        if filterSelections == [false, false, false, false, false] {
            resetButton.isEnabled = false
        } else {
            resetButton.isEnabled = true
        }

        
    }

  //functions
    
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//   
//    }
    
    
    func determineFilterSelections() {
        dueTodaySwitch.isOn = filterSelections[0]
        dueThisWeekSwitch.isOn = filterSelections[1]
        pastDueSwitch.isOn = filterSelections[2]
        isImportantSwitch.isOn = filterSelections[3]
        audioSwitch.isOn = filterSelections[4]
        //sortControl.selectedSegmentIndex = sortSelection!
    }
    
    func defaultFilterState() {
        //sortSelection = 0
        filterSelections[0] = false
        filterSelections[1] = false
        filterSelections[2] = false
        filterSelections[3] = false
        filterSelections[4] = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
       

        
        let nextVC = segue.destination as! TasksViewController
        nextVC.filterSelections = filterSelections
       // nextVC.sortSelection = sortSelection
        
        
    }

    
    //actions
    
    @IBAction func applyButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindToTasksWithFilter", sender: filterSelections)
        
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        resetButton.isEnabled = false
       applyButton.title = "Apply"
        defaultFilterState()
        determineFilterSelections()
    }
    
    
    @IBAction func dueTodayTapped(_ sender: Any) {
      

        applyButton.title = "Apply"
        if dueTodaySwitch.isOn == true {
            filterSelections[0] = true
        }else {
            filterSelections[0] = false
        }
        if filterSelections == [false, false, false, false, false] {
            resetButton.isEnabled = false
        } else {
            resetButton.isEnabled = true
        }

        
    }
    
    
    @IBAction func dueThisWeekTapped(_ sender: Any) {
       
        applyButton.title = "Apply"
        
        
        if dueThisWeekSwitch.isOn == true {
            filterSelections[1] = true
            dueTodaySwitch.isOn = true
            filterSelections[0] = true
            dueTodaySwitch.isEnabled = false
        }else {
            filterSelections[1] = false
            dueTodaySwitch.isEnabled = true
        }
        
        if filterSelections == [false, false, false, false, false] {
            resetButton.isEnabled = false
        } else {
            resetButton.isEnabled = true
        }

    }
    
    @IBAction func pastDueTapped(_ sender: Any) {
       

        applyButton.title = "Apply"
        if pastDueSwitch.isOn == true {
            filterSelections[2] = true
            
        }else {
            filterSelections[2] = false
        }
        
        if filterSelections == [false, false, false, false, false] {
            resetButton.isEnabled = false
        } else {
            resetButton.isEnabled = true
        }

    }
    
    @IBAction func importantTapped(_ sender: Any) {
        
      applyButton.title = "Apply"
        if isImportantSwitch.isOn == true {
            filterSelections[3] = true
        }else {
            filterSelections[3] = false
        }
        
        if filterSelections == [false, false, false, false, false]  {
            resetButton.isEnabled = false
        } else {
            resetButton.isEnabled = true
        }

        
    }
    
    
    @IBAction func audioSwitchTapped(_ sender: Any) {
       

        applyButton.title = "Apply"
        if audioSwitch.isOn == true {
            filterSelections[4] = true
        }else {
            filterSelections[4] = false
        }
        
        if filterSelections == [false, false, false, false, false]  {
            resetButton.isEnabled = false
        } else {
            resetButton.isEnabled = true
        }

    }
    
    
//    @IBAction func sortControlTapped(_ sender: Any) {
//       
//
//        applyButton.title = "Apply"
//        if sortControl.selectedSegmentIndex == 0 {
//            sortSelection = 0
//        }
//        
//        if sortControl.selectedSegmentIndex == 1 {
//            sortSelection = 1
//        }
//        
//        if sortControl.selectedSegmentIndex == 2 {
//            sortSelection = 2
//        }
//        
//        if filterSelections == [false, false, false, false, false] && sortSelection == 0 {
//            resetButton.isEnabled = false
//        } else {
//            resetButton.isEnabled = true
//        }
//
//    }
    

}
