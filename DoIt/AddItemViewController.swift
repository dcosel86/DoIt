//
//  AddItemViewController.swift
//  DoIt
//
//  Created by Amanda Cosel on 3/19/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    

   var fromAddList : Bool = false
    var fromAddTask : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
       

        // Do any additional setup after loading the view.
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
                return .none
        
            }
    
   
    
   
    @IBAction func listButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "unwindToListFromAddList", sender: [fromAddList])
        
    }
    
    
    @IBAction func taskButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "unwindToListFromAddTask", sender: [fromAddList])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindToListFromAddList" {
            let nextVC = segue.destination as! TasksViewController
            nextVC.fromAddList = true
            
        }
        
        if segue.identifier == "unwindToListFromAddTask" {
            let nextVC = segue.destination as! TasksViewController
            nextVC.fromAddTask = true
            
        }

        
        
        
    }

    
    
//    @IBAction func taskButtonTapped(_ sender: Any) {
//    }
    

    
//    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
//        return UIModalPresentationStyle.none
//    }

   

   
}

