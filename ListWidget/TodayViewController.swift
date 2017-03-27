//
//  TodayViewController.swift
//  ListWidget
//
//  Created by Amanda Cosel on 3/21/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var listWidgetLabel: UILabel!
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        if let textFromApp = UserDefaults.init(suiteName: "group.com.dcapps.DoIts.ListWidget")?.value(forKey: "textFromApp") {
//            self.listWidgetLabel.text = textFromApp as? String
//        }else {
//            self.listWidgetLabel.text = "boo hoo"
//        }
//        
//        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        
        
        // Do any additional setup after loading the view from its nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let textFromApp = UserDefaults.init(suiteName: "group.com.dcapps.DoIts.ListWidget")?.value(forKey: "textFromApp") {
            self.listWidgetLabel.text = textFromApp as? String
        }else {
            self.listWidgetLabel.text = "boo hoo"
        }
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
       
        
        if let textFromApp = UserDefaults.init(suiteName: "group.com.dcapps.DoIts.ListWidget")?.value(forKey: "textFromApp") {
        
            if textFromApp as? String != self.listWidgetLabel.text {
                self.listWidgetLabel.text = textFromApp as? String
                completionHandler(NCUpdateResult.newData)
            } else {
                completionHandler(NCUpdateResult.noData)
            }
            
        } else {
             self.listWidgetLabel.text = "boo hoo"
            completionHandler(NCUpdateResult.newData)
        }
   
    }
    
    
    }
