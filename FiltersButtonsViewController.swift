//
//  FiltersButtonsViewController.swift
//  DoIts
//
//  Created by Amanda Cosel on 4/13/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit

class FiltersButtonsViewController: UIViewController {

    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var filterNameLabel: UILabel!
    
    @IBOutlet weak var filterView: UIView!
    
    @IBOutlet weak var filterImage: UIImageView!
    
    @IBOutlet weak var filterExpand: UIImageView!
    
    @IBOutlet weak var sortImage: UIImageView!
    
    @IBOutlet weak var sortExpand: UIImageView!
    
    @IBOutlet weak var sortName: UILabel!
    
    
    @IBOutlet weak var sortButton: UIButton!
    
    @IBOutlet weak var sortView: UIView!
    
    
    
    var filterSelections = filters?.filterSelections
    
        
       // [false, false, false, false, false, true, true]
    var sortSelection = 3
    var filterLabel : String? = filters?.name
    var sortNamer : String? = sorting?.sortName
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload , object: nil)
        
        filterNameLabel.text = filters?.name
        sortSelection = (sorting?.sortSelection)!
        sortNamer = sorting?.sortName
        
        if (filters?.filterSelections[0] == false && filters?.filterSelections[1] == false && filters?.filterSelections[2] == false && filters?.filterSelections[3] == false && filters?.filterSelections[4] == false && filters?.filterSelections[5] == true && filters?.filterSelections[6] == true) != true {
            
            
            
            filterView.backgroundColor = UIColor.darkGray
            
            //(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
            
            filterNameLabel.textColor = UIColor.white
            
            filterNameLabel.layer.borderColor = UIColor.white.cgColor
            
            
            
            filterImage.image = filterImage.image!.withRenderingMode(.alwaysTemplate)
            filterImage.tintColor = UIColor.white
            
            filterExpand.image = filterExpand.image!.withRenderingMode(.alwaysTemplate)
            filterExpand.tintColor = UIColor.white
            
            
        }else {
            
            filterView.backgroundColor = UIColor.groupTableViewBackground
            
            filterNameLabel.textColor = UIColor.black
            
            filterNameLabel.layer.borderColor = UIColor.lightGray.cgColor
            
            filterImage.tintColor = UIColor.black
            
            filterExpand.tintColor = UIColor.black
            
            filterImage.image = filterImage.image!.withRenderingMode(.alwaysTemplate)
            filterImage.tintColor = UIColor.black
            
            filterExpand.image = filterExpand.image!.withRenderingMode(.alwaysTemplate)
            filterExpand.tintColor = UIColor.black
            
        }
        
        
        
        if sortSelection == 0 {
            sortName.text = "Priority"
            
        }
        
        if sortSelection == 1 {
            
            sortName.text = "Due Date"
        }
        
        if sortSelection == 2 {
            
            sortName.text = "Created Date"
            
        }
        
        if sortSelection == 3 {
            sortName.text = "Task Name"
            
        }
        
        
        if sortSelection != 3 {
            
            
            
            
            
            sortView.backgroundColor = UIColor.darkGray
            
            //(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
            
            sortName.textColor = UIColor.white
            
            sortName.layer.borderColor = UIColor.white.cgColor
            
            
            
            sortImage.image = sortImage.image!.withRenderingMode(.alwaysTemplate)
            sortImage.tintColor = UIColor.white
            
            sortExpand.image = sortExpand.image!.withRenderingMode(.alwaysTemplate)
            sortExpand.tintColor = UIColor.white
            
            
        }else {
            
            sortView.backgroundColor = UIColor.groupTableViewBackground
            
            sortName.textColor = UIColor.black
            
            sortName.layer.borderColor = UIColor.lightGray.cgColor
            
            sortImage.tintColor = UIColor.black
            
            sortExpand.tintColor = UIColor.black
            
            sortImage.image = sortImage.image!.withRenderingMode(.alwaysTemplate)
            sortImage.tintColor = UIColor.black
            
            sortExpand.image = sortExpand.image!.withRenderingMode(.alwaysTemplate)
            sortExpand.tintColor = UIColor.black
            
        }


        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        
        
       
    }
    
    func reloadTableData(_ notification: Notification) {
        self.viewDidLoad()
    }
    
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "haha", sender: sortSelection)
        
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "hehe", sender: filterSelections)
     
    }
    
   
  
    
    
    

    }
