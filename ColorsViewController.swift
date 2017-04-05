//
//  ColorsViewController.swift
//  DoIts
//
//  Created by Amanda Cosel on 4/4/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import CoreData

class ColorsViewController: UIViewController {
    
    
    var selectedColor : UIColor = UIColor.white

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        
    }
    
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindToCatsFromColors" {
            let nextVC = segue.destination as! CategoriesViewController
            nextVC.selectedColor = self.selectedColor as UIColor        }
        
    }
    
    @IBAction func whiteButtonTapped(_ sender: Any) {
        selectedColor = UIColor.white
        performSegue(withIdentifier: "unwindToCatsFromColors", sender: selectedColor)
    }
    
    @IBAction func grayButtonTapped(_ sender: Any) {
        
        selectedColor = UIColor.lightGray
        performSegue(withIdentifier: "unwindToCatsFromColors", sender: selectedColor)
    }
    
    @IBAction func salmonButtonTapped(_ sender: Any) {
        selectedColor = UIColor(colorLiteralRed: 255/200, green: 102/255, blue: 102/255, alpha: 1)
        performSegue(withIdentifier: "unwindToCatsFromColors", sender: selectedColor)
    }
    
    @IBAction func forestButtonTapped(_ sender: Any) {
        
         selectedColor = UIColor(colorLiteralRed: 0/200, green: 128/255, blue: 0/255, alpha: 1)
        performSegue(withIdentifier: "unwindToCatsFromColors", sender: selectedColor)
        
    }
    
    
    @IBAction func bannanaButtonTapped(_ sender: Any) {
        
         selectedColor = UIColor(colorLiteralRed: 255/200, green: 255/255, blue: 102/255, alpha: 1)
        performSegue(withIdentifier: "unwindToCatsFromColors", sender: selectedColor)
    }
   
    @IBAction func blueButtonTapped(_ sender: Any) {
        
         selectedColor = UIColor(colorLiteralRed: 0/200, green: 122/255, blue: 255/255, alpha: 1)
        performSegue(withIdentifier: "unwindToCatsFromColors", sender: selectedColor)
    }
    
    @IBAction func magentaButtonTapped(_ sender: Any) {
        
         selectedColor = UIColor(colorLiteralRed: 255/200, green: 0/255, blue: 255/255, alpha: 1)
        performSegue(withIdentifier: "unwindToCatsFromColors", sender: selectedColor)
    }
    

    
    
   }
