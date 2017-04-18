//
//  CreateTaskViewController.swift
//  DoIt
//
//  Created by Amanda Cosel on 1/29/17.
//  Copyright © 2017 DCApps. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class CreateTaskViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    
    //varialbles
    var tasks : [Task] = []
    var task : Task? = nil
    var comp = DateComponents()
    var datePickerView : UIDatePicker = UIDatePicker()
    var date = Date()
    var categories : [Category] = []
    var audioRecorder : AVAudioRecorder? = nil
    var audioPlayer : AVAudioPlayer? = nil
    var audioURL : URL?
    var selectedCategory : Category? = nil
    var important : Bool? = nil
    let alert = UIAlertController(title: "Delete Audio Note", message: "This will delete the audio note associated with this task", preferredStyle: .actionSheet)
   var updater : CADisplayLink! = nil
   var toggleState = 1
    var audioTime : TimeInterval? = 0.0
    var playedTimer : String = "00:00 / 00:00"
    let calendar = Calendar.current
   
    
   
    
    
   
    //outlets
    
    
   // @IBOutlet weak var addAudioNoteButton: UIButton!
    
    @IBOutlet weak var taskNoteLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var playRecordView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    //@IBOutlet weak var importantSwitch: UISwitch!
    
    @IBOutlet weak var notesTextField: UITextView!
    
    @IBOutlet weak var dateFieldText: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var createTaskView: CreateTaskView!

    @IBOutlet weak var didItButton: UIButton!
    
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var recordStopButton: UIButton!
    
    @IBOutlet weak var dueDateButton: UIButton!
    
    @IBOutlet weak var audioNoteButton: UIButton!
    
    @IBOutlet weak var importantButton: UIButton!
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
   // @IBOutlet weak var audioLabel: UILabel!
    
    @IBOutlet weak var taskNotesLabel: UILabel!
    
    @IBOutlet weak var audioBar: UISlider!
    
    
    @IBOutlet weak var playedTime: UILabel!
    
    @IBOutlet weak var recordingMessage: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var undoButton: UIButton!
    
    //functions
    
    override func viewDidLoad() {
        
        
      //  UINavigationBar.appearance().barTintColor = UIColor.lightGray
        
        
        createTaskView.layer.cornerRadius = 10
        colorView.layer.cornerRadius = 10
        
        
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
//        
//       UINavigationBar.appearance().tintColor = UIColor.white
        
        
        super.viewDidLoad()
        self.categoryPicker.dataSource = self;
        self.categoryPicker.delegate = self;
        self.taskNameTextField.delegate = self;
        //self.notesTextField.delegate = self;
        playPauseButton.isEnabled = false
        
        getCategories()
        getTasks()
        
        if selectedCategory == nil {
            selectedCategory = categories[0]
        }
       
        self.hideKeyboardWhenTappedAround()
           
        notesTextField.selectedRange = NSMakeRange(2, 0)
        
        //notesTextField.selectedRange = NSMakeRange(2, 0);
//        if audioURL != nil {
//        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CreateTaskViewController.updateSlider), userInfo: nil, repeats: true)
//       
//        }
        
        let upThumbImage : UIImage = UIImage(named: "circleSlider.png")!
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContext(size)
        upThumbImage.draw(in: CGRect(x:0, y:0, width:size.width, height:size.height))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        audioBar.setThumbImage(resizeImage, for: .normal)
        
        recordingMessage.isHidden = true
        recordingMessage.text = "Recording in progress . . . . ."
        
        let origPlayImage = UIImage(named: "Play Filled-50.png")
        let tintedPlayImage = origPlayImage?.withRenderingMode(.alwaysTemplate)
        
        let origRecordImage = UIImage(named: "Record Filled-50.png")
        let tintedRecordImage = origRecordImage?.withRenderingMode(.alwaysTemplate)
    
        
        //load date picker
        datePickerView.datePickerMode = UIDatePickerMode.date
        //datePickerView.minimumDate = date
        dateFieldText.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(CreateTaskViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        datePickerView.backgroundColor = UIColor.groupTableViewBackground
       
       
        //load category picker
        categoryTextField.inputView = UIView()
        
        categoryPicker.isHidden = true
        
        
        
        if task != nil {
            
            if task?.dueDate != nil{
                
                  let dateFromTask = task?.dueDate
                let dateFormatter = DateFormatter()
                 dateFormatter.dateStyle = .long
                
                let startOfTask = calendar.startOfDay(for: dateFromTask as! Date)
                
                let startOfToday = calendar.startOfDay(for: Date())
                
                let todaysDate = dateFormatter.string(from: Date())
                
                let numOfDays: Int = daysBetweenDates(startDate: startOfToday , endDate: startOfTask as! Date)
                
                if numOfDays > 100000 {
                    task?.dueDate = nil
                }
                
                
                
          
            
           
            let dateToShow = "\(dateFormatter.string(from: dateFromTask as! Date))"
                dueDateLabel.isHidden = false
                dateFieldText.isHidden = false
                dateFieldText.text = dateToShow
                
                           }
            
            taskNameTextField.text = task?.taskName
            notesTextField.text = task?.taskNotes
//            importantSwitch.isOn = (task?.important)!
            
            important = task?.important
           
            task!.taskPriority = task!.taskPriority
            task?.audioNote = task?.audioNote
            
            
            if task?.completed == true {
                deleteButton.isHidden = false
                deleteButton.isEnabled = true
                addButton.isEnabled = false
                addButton.isHidden = true
                didItButton.isHidden = true
                didItButton.isEnabled = false
                audioNoteButton.isEnabled = false
                dueDateButton.isEnabled = false
                importantButton.isEnabled = false
                recordStopButton.isEnabled = false
                taskNameTextField.isUserInteractionEnabled = false
                notesTextField.isUserInteractionEnabled = false
                dateFieldText.isUserInteractionEnabled = false
                categoryTextField.isUserInteractionEnabled = false
                undoButton.isHidden = false
                undoButton.isEnabled = true
                
                
            }else {
                deleteButton.isHidden = true
                deleteButton.isEnabled = false
            addButton.setTitle("Update", for: .normal)
            addButton.isEnabled = false
            addButton.isHidden = true
            didItButton.isHidden = false
            didItButton.isEnabled = true
                audioNoteButton.isEnabled = true
                dueDateButton.isEnabled = true
                importantButton.isEnabled = true
                recordStopButton.isEnabled = true
                taskNameTextField.isUserInteractionEnabled = true
                notesTextField.isUserInteractionEnabled = true
                dateFieldText.isUserInteractionEnabled = true
                categoryTextField.isUserInteractionEnabled = true
                undoButton.isHidden = true
                undoButton.isEnabled = false
                
               
            }
            
//            if task?.dueDate != nil {
//                dueDateButton.setImage(UIImage(named: "Clock Filled-50.png"), for: UIControlState.normal)
//            } else {
//                print ("no due date")
//            }
            
//            if task?.important == true {
//                importantButton.setImage(UIImage(named: "Low Importance Filled-50.png"), for: UIControlState.normal)
//            } else {
//                print ("not important")
//            }
            
            if task?.dueDate != nil {
                dueDateLabel.isHidden = false
                dateFieldText.isHidden = false
            } else {
                dueDateLabel.isHidden = true
                dateFieldText.isHidden = true
            }
            
            
            if task?.audioNote != nil {
                playRecordView.isHidden = false
               // audioLabel.isHidden = false
//                addAudioNoteButton.isHidden = true
//                addAudioNoteButton.isEnabled = false
               // setUpRecorder()
                
                recordStopButton.setImage(tintedRecordImage, for: .normal)
                recordStopButton.tintColor = UIColor.red
                playPauseButton.tintColor = UIColor.darkGray
                playPauseButton.isEnabled = true
//                _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CreateTaskViewController.updateSlider), userInfo: nil, repeats: true)
                
                do {
                    
                    try audioPlayer = AVAudioPlayer(data: task!.audioNote! as Data)
                    audioBar.maximumValue = Float((audioPlayer?.duration)!)
                } catch {
                    
                    print("error")
                }
                
                updateTime()
                
                
                
               // audioBar.maximumValue = Float((audioPlayer?.duration)!)
//                audioNoteButton.setImage(UIImage(named: "Circled Play Filled-50.png"), for: UIControlState.normal)
                
            } else {
                playRecordView.isHidden = true
                playedTime.text = "00:00 / 00:00"
                
                //audioLabel.isHidden = true
                
//                addAudioNoteButton.isHidden = false
                //addAudioNoteButton.isEnabled = true
            }
            if task?.taskCategory != nil {
                categoryTextField.text = "\(task!.taskCategory!.categoryName!)"
                determineIndexOfTaskCategory()
            }else {
                categoryTextField.text = "\(categories[0].categoryName!)"
            }
            
            
        determineButtonFill()
            determineTintOfTask()
        
        }
        else {
            undoButton.isHidden = true
            undoButton.isEnabled = false
            deleteButton.isHidden = true
            deleteButton.isEnabled = false
            important = false
             addButton.setTitle("Add", for: .normal)
            addButton.isEnabled = false
            addButton.isHidden = false
            didItButton.isHidden = true
            didItButton.isEnabled = false
            playRecordView.isHidden = true
            //audioLabel.isHidden = true
//            categoryPicker.isHidden = true
            dateFieldText.isHidden = true
            dueDateLabel.isHidden = true
            //addAudioNoteButton.isHidden = false
           // addAudioNoteButton.isEnabled = true
            if selectedCategory != nil {
                categoryTextField.text = selectedCategory?.categoryName
                determineIndexOfSelectedCategory()
            }else {
            categoryTextField.text = "\(categories[0].categoryName!)"
                
            }
            
            determineButtonFill()
            determineTintOfTask()
        }
        
        if selectedCategory != nil {
        colorView.backgroundColor = selectedCategory?.color as! UIColor
        } else {
            colorView.backgroundColor = categories[0].color as! UIColor
        }
        

    }

       
    
    
    override func viewWillAppear(_ animated: Bool) {
      
       
        
        if selectedCategory != nil {
       determineIndexOfSelectedCategory()
        }
    }
    
    
    
    func numberOfComponents(in categoryPicker: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ categoryPicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (categories.count)
    }
    
    
    func pickerView(_ categoryPicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        let category = categories[row]
        let categoryName = (category.categoryName)
        return (categoryName)
    }
    
    func pickerView(_ categoryPicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        let category = categories[row]
        let selectedsCategory = (category.categoryName)
        categoryTextField.text = "\(selectedsCategory!)"
        colorView.backgroundColor = category.color as! UIColor
        if category.color == UIColor.white {
            
            didItButton.tintColor = UIColor.darkGray
            cancelButton.tintColor = UIColor.darkGray
            audioNoteButton.tintColor = UIColor.darkGray
            importantButton.tintColor = UIColor.darkGray
            dueDateButton.tintColor = UIColor.darkGray
            addButton.tintColor = UIColor.darkGray
            
            
        } else if category.color == UIColor(colorLiteralRed: 255/200, green: 255/255, blue: 102/255, alpha: 1) {
            didItButton.tintColor = UIColor.darkGray
            cancelButton.tintColor = UIColor.darkGray
            audioNoteButton.tintColor = UIColor.darkGray
            importantButton.tintColor = UIColor.darkGray
            dueDateButton.tintColor = UIColor.darkGray
            addButton.tintColor = UIColor.darkGray
            
            
        } else {
            
            didItButton.tintColor = UIColor.white
            cancelButton.tintColor = UIColor.white
            audioNoteButton.tintColor = UIColor.white
            addButton.tintColor = UIColor.white
            
            importantButton.tintColor = UIColor.white
            dueDateButton.tintColor = UIColor.white
            
            
        }

    }
    
    
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func determineIndexOfTaskCategory() {
        
        
        var location = categories.index(of: task!.taskCategory!)
        categoryPicker.selectRow(location!, inComponent: 0, animated: true)
        
    }
    
    
    func determineIndexOfSelectedCategory() {
        
        var location = categories.index(of: selectedCategory!)

         categoryPicker.selectRow(location!, inComponent: 0, animated: true)
    }
    
    
    func getTasks () {
        
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let entity = NSEntityDescription.entity(
                    forEntityName: "Task", in: context)
                let request: NSFetchRequest<Task> = Task.fetchRequest()
                request.entity = entity
                let pred = NSPredicate(format: "(completed == %@)", false as CVarArg)
                request.predicate = pred
                do{
                    tasks = try context.fetch(request as!
                        NSFetchRequest<NSFetchRequestResult>) as! [Task]
                } catch {}
                
                
               
            }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        taskNameTextField.resignFirstResponder()
        notesTextField.resignFirstResponder()
        return (true)
    }
    
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.long
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateFieldText.text = dateFormatter.string(from: sender.date)
        
    }
    
    func determineButtonFill() {
    
//        taskNotesLabel.translatesAutoresizingMaskIntoConstraints = false
//        let verticalNoteLabelSpace = NSLayoutConstraint(item: dateFieldText, attribute: .top, relatedBy: .equal, toItem: taskNotesLabel, attribute: .bottom, multiplier: 1, constant: -155)
//        let leftNoteLabelConstraint = taskNotesLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
//        
//        let verticalNoteLabelSpace2 = NSLayoutConstraint(item: dateFieldText, attribute: .top, relatedBy: .equal, toItem: taskNotesLabel, attribute: .bottom, multiplier: 1, constant: 5)
//        let leftNoteLabelConstraint2 = taskNotesLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20)
    //set play image tint
        
        if playRecordView.isHidden == false {
            let origAudioImage = UIImage(named: "Circled Play Filled-50.png")
            let tintedAudioImage = origAudioImage?.withRenderingMode(.alwaysTemplate)
            audioNoteButton.setImage(tintedAudioImage, for: .normal)
            //audioNoteButton.tintColor = UIColor.lightGray
            
            //(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
        } else {
    let origAudioImage = UIImage(named: "Circled Play-50.png")
    let tintedAudioImage = origAudioImage?.withRenderingMode(.alwaysTemplate)
    audioNoteButton.setImage(tintedAudioImage, for: .normal)
    //audioNoteButton.tintColor = UIColor.lightGray
        }
    
    //set urgent image tint
        if important == true {
            let origUrgentImage = UIImage(named: "High importance Filled-50.png")
            let tintedUrgentImage = origUrgentImage?.withRenderingMode(.alwaysTemplate)
            importantButton.setImage(tintedUrgentImage, for: .normal)
            //importantButton.tintColor = UIColor.lightGray
            
            //(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
            
        } else {
    let origUrgentImage = UIImage(named: "High importance-50.png")
    let tintedUrgentImage = origUrgentImage?.withRenderingMode(.alwaysTemplate)
    importantButton.setImage(tintedUrgentImage, for: .normal)
    //importantButton.tintColor = UIColor.lightGray
            print ("I did it!")
        }
    
    //set urgent image tint
        if dateFieldText.isHidden == false {
            let origDatetImage = UIImage(named: "Clock Filled-50.png")
            let tintedDateImage = origDatetImage?.withRenderingMode(.alwaysTemplate)
            dueDateButton.setImage(tintedDateImage, for: .normal)
            //dueDateButton.tintColor = UIColor.lightGray
            
            //(colorLiteralRed: 75/200, green: 156/255, blue: 56/255, alpha: 1)
            

            
//            NSLayoutConstraint.activate([verticalNoteLabelSpace, leftNoteLabelConstraint])
           
            taskNoteLabelConstraint.constant = 80

            
            
        }else {
    let origDatetImage = UIImage(named: "Clock-50.png")
    let tintedDateImage = origDatetImage?.withRenderingMode(.alwaysTemplate)
    dueDateButton.setImage(tintedDateImage, for: .normal)
   // dueDateButton.tintColor = UIColor.lightGray
            
           
            
//            NSLayoutConstraint.deactivate([verticalNoteLabelSpace, leftNoteLabelConstraint])
            
            taskNoteLabelConstraint.constant = 5
            
            
        }

    }
    
    
    
    @IBAction func dateChanged(_ sender: Any) {
        if task != nil {
            addButton.setTitle("Update", for: .normal)
            addButton.isEnabled = true
            addButton.isHidden = false
            didItButton.isEnabled = false
            didItButton.isHidden = true
        }
    }
    
    
    @IBAction func categoryChanged(_ sender: Any) {
        if task != nil {
            addButton.setTitle("Update", for: .normal)
            addButton.isEnabled = true
            addButton.isHidden = false
            didItButton.isEnabled = false
            didItButton.isHidden = true
        }
    }

    
   
    
    @IBAction func taskNameChnaged(_ sender: Any) {
        addButton.isEnabled = true
        if task != nil {
             addButton.setTitle("Update", for: .normal)
            addButton.isEnabled = true
            addButton.isHidden = false
            didItButton.isEnabled = false
            didItButton.isHidden = true
        }
    }
    
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        
        if task != nil {
            addButton.setTitle("Update", for: .normal)
            addButton.isEnabled = true
            addButton.isHidden = false
            didItButton.isEnabled = false
            didItButton.isHidden = true
        }

        
        
        
        if dateFieldText.isHidden == true {
            dueDateLabel.isHidden = false
            dateFieldText.isHidden = false
            datePickerView.isHidden = false
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateStyle = DateFormatter.Style.long
            
            dateFormatter.timeStyle = DateFormatter.Style.none
            
            dateFieldText.text = dateFormatter.string(for: Date())
            
            
        }  else {
            dueDateLabel.isHidden = true
            dateFieldText.isHidden = true
            dateFieldText.text = nil
           
          
        }
        determineButtonFill()
        determineTintOfTask()
        
    
        
    }
    
    
    
    @IBAction func audioNoteButtonTapped(_ sender: Any) {
        
        let origRecordImage = UIImage(named: "Record Filled-50.png")
        let tintedRecordImage = origRecordImage?.withRenderingMode(.alwaysTemplate)
        
        
        
         if ((task?.audioNote == nil) && (audioURL == nil) && (playRecordView.isHidden == false)) == true {
            
            playRecordView.isHidden = true
            determineButtonFill()
            determineTintOfTask()
            
        }
        
        
       else if ((task?.audioNote == nil) && (audioURL == nil) && (playRecordView.isHidden == true)) == true {
//        if audioURL == nil {
        playRecordView.isHidden = false
            //audioLabel.isHidden = false
            recordStopButton.setImage(tintedRecordImage, for: .normal)
            recordStopButton.tintColor = UIColor.red
            playPauseButton.isEnabled = false
        //addAudioNoteButton.isHidden = true
        //addAudioNoteButton.isEnabled = false
        //setUpRecorder()
            determineButtonFill()
            determineTintOfTask()
        } else {
            
        self.present(self.alert, animated: true, completion: nil)
            
        self.alert.addAction(UIAlertAction(title: "Sure go ahead", style: .default, handler: { (action) in
        
        self.playRecordView.isHidden = true
           // self.audioLabel.isHidden = true
        //addAudioNoteButton.isHidden = false
        //addAudioNoteButton.isEnabled = true
            
            
            if self.audioURL != nil {
        self.audioURL = nil
            }
            if self.task?.audioNote != nil {
            self.task?.audioNote = nil
            }
            self.determineButtonFill()
            self.determineTintOfTask()
            

            
        }))
            self.alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                
                self.determineButtonFill()
                self.determineTintOfTask()
                
            }))
        }
       
    }
    
    
//    @IBAction func impSwitchTapped(_ sender: Any) {
//        if task != nil {
//             addButton.setTitle("Update", for: .normal)
//            addButton.isEnabled = true
//            addButton.isHidden = false
//            didItButton.isEnabled = false
//            didItButton.isHidden = true
//        }
//    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        audioRecorder?.stop()
        audioPlayer?.stop()
        self.performSegue(withIdentifier: "unwindToTasks", sender: self)
       
    }
    
    
    @IBAction func editDidBegin(_ sender: Any) {
        categoryPicker.isHidden = false
    }
    
    @IBAction func editsEnd(_ sender: Any) {
        categoryPicker.isHidden = true
    }
    
    
    
    
    @IBAction func importantButtonTapped(_ sender: Any) {
        
        if important == true {
            self.important = false
        } else {
            self.important = true
        }
        
        if task != nil{
        addButton.setTitle("Update", for: .normal)
        addButton.isEnabled = true
        addButton.isHidden = false
        didItButton.isEnabled = false
        didItButton.isHidden = true
        }
        
        determineButtonFill()
        determineTintOfTask()
        
    }
    
    
    
    //actions
    
    
    @IBAction func tapOutOfCreate(_ sender: Any) {
        audioRecorder?.stop()
        audioPlayer?.stop()
        self.performSegue(withIdentifier: "unwindToTasks", sender: self)
    }
    
    
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(task!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        self.performSegue(withIdentifier: "unwindToTasks", sender: self)
    }
    
    
    
    
    @IBAction func didItButtonTapped(_ sender: Any) {
        audioRecorder?.stop()
        audioPlayer?.stop()
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       task!.completed = true
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        self.performSegue(withIdentifier: "unwindToTasks", sender: self)
        
    }
    
    
    
    @IBAction func undoButtonTapped(_ sender: Any) {
        
        
        audioRecorder?.stop()
        audioPlayer?.stop()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        task!.completed = false
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        self.viewDidLoad()
        
        
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        audioRecorder?.stop()
        audioPlayer?.stop()
        
        if task != nil {
            //access core data
            
            
            do {
                
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let task2 = Task(context: context)
                
            
                
                let categoryRow2 = categoryPicker.selectedRow(inComponent: 0)
                let category2 : Category = categories[categoryRow2]
                let dateString : String? = dateFieldText.text!
                 let dateFormatter : DateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "MM-dd-yyyy"
                 let dateToSave = dateFormatter.date(from: dateString!)
                
                if ((task?.audioNote != nil) && (audioURL != nil)) == true {
                    task2.audioNote = NSData(contentsOf: audioURL!)
                } else if ((task?.audioNote != nil) && (audioURL == nil)) == true{
                    task2.audioNote = task?.audioNote
                } else if ((task?.audioNote == nil) && (audioURL != nil)) == true{
                    task2.audioNote = NSData(contentsOf: audioURL!)
                    print ("YOOO")
                } else {
                    try task2.audioNote? = NSData(contentsOf: audioURL!)

                }
                
                
                
//                if task?.audioNote != nil {
//                    task2.audioNote = task?.audioNote
//                }
//                else if audioURL != nil {
//                    task2.audioNote = NSData(contentsOf: audioURL!)
//                } else {
//                    try task2.audioNote? = NSData(contentsOf: audioURL!)
//                }

                task2.taskName = taskNameTextField.text
                task2.taskNotes = notesTextField.text
                task2.important = important!
                task2.completed = false
                task2.taskPriority = task!.taskPriority
                
                if dateToSave != nil {
                    task2.dueDate = dateToSave as NSDate?
                }else {
                    task2.dueDate = nil
                }

                
                
                task2.setValue(category2, forKey: "taskCategory")
                
                task2.createdDate = task!.createdDate
                
                try (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                
            } catch {}
            
            do {
                
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                //let task = Task(context: context)
                context.delete(task!)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                self.performSegue(withIdentifier: "unwindToTasks", sender: self)
                
                
              
                
                
                
            }catch {}
            
        } else {
            
            do {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let task = Task(context: context)
            let categoryRow = categoryPicker.selectedRow(inComponent: 0)
            let category : Category = categories[categoryRow]
            
             let dateString : String? = dateFieldText.text!
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "MM-dd-yyyy"
             let dateToSave = dateFormatter.date(from: dateString!)
             
            
            
            task.taskName = taskNameTextField.text!
            task.important = important!
            task.taskNotes = notesTextField.text
            task.completed = false
                
                if dateToSave != nil {
            task.dueDate = dateToSave as NSDate?
                }else {
                    task.dueDate = nil
                }
            task.setValue(category, forKey: "taskCategory")
            task.createdDate = NSDate()
                if audioURL != nil {
            task.audioNote = NSData(contentsOf: audioURL!)
                } else {
                    try task.audioNote? = NSData(contentsOf: audioURL!)
                }
            
            if important == true {
                task.taskPriority = -1
            }else {
                task.taskPriority = Int64((tasks.count))
            }
            
            //task.categoryName = categoryTextField.text
            
            
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            } catch {}
            
           self.performSegue(withIdentifier: "unwindToTasks", sender: self)
        

    }
    
    }
    
    
   
   
    
    
 
    
    func allButtonsDisabled () {
        addButton.isEnabled = false
    }
    
    func switchButtonToUpdate () {
        addButton.isEnabled = true
        
        }
    
    func defaultButtonState () {
        addButton.isEnabled = false
        
    }
    
    
    
    @IBAction func pageSwiped(_ sender: UISwipeGestureRecognizer) {
        audioRecorder?.stop()
        audioPlayer?.stop()
        self.performSegue(withIdentifier: "unwindToTasks", sender: self)
    }

   
  
    
    func getCategories() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do{
    categories = try context.fetch(Category.fetchRequest())
    print(categories)
    } catch {
    }

    }
   
    
   /*
    
    
    
    func datePickerChanged(datePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let cal = NSCalendar.current
        
        
        let dateComponents = NSDateComponents()
        dateComponents.day = 4
        dateComponents.month = 5
        dateComponents.year = 2006
        
        if let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian),
            let date = gregorianCalendar.date(from: dateComponents as DateComponents) {
            let weekday = gregorianCalendar.component(.weekday, from: date)
            print(weekday) // 5, which corresponds to Thursday in the Gregorian Calendar
        }
        
        
        //comp = cal.dateComponents(.Day, .Month, .Year, .Hour, .Minute, from: date)

        
    
        // getting day, month, year ect
        print ("Era:\(comp.era) Date:\(comp.day) Month:\(comp.month) Month:\(comp.year) Hours: \(comp.hour) Minuts:\(comp.minute)")
    }
    
 */
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day!
    }


    
    func setUpRecorder() {
        
//        if task != nil {
//        //playPauseButton.isEnabled = true
//        }
        
        //create audio session
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //create URL for audio file
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            //settings
            
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            //create audioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch {
            print("error")
            
        }
    }
    
    
//    @IBAction func addAudioNoteButtonTapped(_ sender: Any) {
//        playRecordView.isHidden = false
//        addAudioNoteButton.isHidden = true
//        addAudioNoteButton.isEnabled = false
//        setUpRecorder()
//    }
    
//    
//    @IBAction func deleteAudioNoteButtonTapped(_ sender: Any) {
//        playRecordView.isHidden = true
//        addAudioNoteButton.isHidden = false
//        addAudioNoteButton.isEnabled = true
//        
//        audioURL = nil
//        
//    }
    
//    
//    func determineLayout() {
//        
//       
//        
//       taskNotesLabel.translatesAutoresizingMaskIntoConstraints = false
//       dueDateLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        if dateFieldText.isHidden == false {
//            
//            let verticalSpace = NSLayoutConstraint(item: taskNotesLabel, attribute: .top, relatedBy: .equal, toItem: categoryTextField, attribute: .bottom, multiplier: 1, constant: 0)
//            NSLayoutConstraint.activate([verticalSpace])
//            
//        }
//        
//        
//        
//    }
    

    @IBAction func recordStopTapped(_ sender: Any) {
        
        let origRecordImage = UIImage(named: "Record Filled-50.png")
        let tintedRecordImage = origRecordImage?.withRenderingMode(.alwaysTemplate)
        let origStopImage = UIImage(named: "Stop Filled-50.png")
        let tintedStopImage = origStopImage?.withRenderingMode(.alwaysTemplate)
        let origPlayImage = UIImage(named: "Play Filled-50.png")
        let tintedPlayImage = origPlayImage?.withRenderingMode(.alwaysTemplate)
        
        if task != nil {
        addButton.setTitle("Update", for: .normal)
        addButton.isEnabled = true
        addButton.isHidden = false
        didItButton.isEnabled = false
        didItButton.isHidden = true
        }
            
            
        if audioURL == nil {
            setUpRecorder()
           
        }
        
        var recordingTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(CreateTaskViewController.recordingInProgress),
                                         userInfo: nil, repeats: true)
        
        
        if audioRecorder!.isRecording {
            audioRecorder!.stop()
            
        
            recordStopButton.setImage(tintedRecordImage, for: .normal)
            recordStopButton.tintColor = UIColor.red
            
            
            
            
            playPauseButton.isEnabled = true
           playPauseButton.setImage(tintedPlayImage, for: .normal)
            playPauseButton.tintColor = UIColor.darkGray
            
        } else {
            audioRecorder!.record()
            
            recordStopButton.setImage(tintedStopImage, for: .normal)
            recordStopButton.tintColor = UIColor.darkGray
            playPauseButton.isEnabled = false
            
            
            }
        
        
        
}
    

    
    
    @IBAction func playPauseTapped(_ sender: Any) {
        
        let origPlayImage = UIImage(named: "Play Filled-50.png")
        let tintedPlayImage = origPlayImage?.withRenderingMode(.alwaysTemplate)
        let origPauseImage = UIImage(named: "Pause Filled-50.png")
        let tintedPauseImage = origPauseImage?.withRenderingMode(.alwaysTemplate)
        
        
        if ((task?.audioNote != nil) && (audioURL != nil)) == true {
            do {
                
                try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
                audioBar.maximumValue = Float((audioPlayer?.duration)!)
                
                
            } catch {
                
                print("error")
            }

        }
        
       else if ((task?.audioNote == nil) && (audioURL != nil)) == true {
            
            
            
            do {
                
                try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
                audioBar.maximumValue = Float((audioPlayer?.duration)!)

                
            } catch {
                
                print("error")
            }
            
        }
        
        else {
            do {
                
                try audioPlayer = AVAudioPlayer(data: task!.audioNote! as Data)
                audioBar.maximumValue = Float((audioPlayer?.duration)!)
            } catch {
                
                print("error")
            }

        }
        
            if toggleState == 1 {
                audioPlayer?.currentTime = audioTime!
                audioPlayer?.play()
                toggleState = 2
                playPauseButton.setImage(tintedPauseImage, for: .normal)
                playPauseButton.tintColor = UIColor.darkGray
                recordStopButton.isEnabled = false
            }else {
              
                audioTime = TimeInterval(audioBar.value)
                audioPlayer?.currentTime = audioTime!
                
                audioPlayer?.pause()
                
              
                toggleState = 1
                playPauseButton.setImage(tintedPlayImage, for: .normal)
                playPauseButton.tintColor = UIColor.darkGray
                recordStopButton.isEnabled = true
            }
        
            
            
        var updateTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CreateTaskViewController.updateSlider),
                                               userInfo: nil, repeats: true)
        
        var timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(CreateTaskViewController.updatePlayImage),
                                         userInfo: nil, repeats: true)
        
        var coutnerTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
        
        
       
        
        
//         if (audioPlayer?.isPlaying) == true{
//            
//            audioPlayer?.pause()
//            playPauseButton.setImage(tintedPlayImage, for: .normal)
//            playPauseButton.tintColor = UIColor.black
//            print ("YO!")
//            
//         } else{
//            
//         
//        updater = CADisplayLink(target: self, selector: #selector(CreateTaskViewController.trackAudio))
//        updater.preferredFramesPerSecond = 1
//        updater.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
//        // let fileURL = NSURL(string: toPass)
//        do {
//        try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
////        audioPlayer = AVAudioPlayer(contentsOf: audioURL, error: nil)
//        //audioPlayer?.numberOfLoops = 0 // play indefinitely
//        audioPlayer?.prepareToPlay()
//        //audioPlayer?.delegate = self
//        audioPlayer?.play()
//        //startTime.text = "\(player.currentTime)"
//        audioBar.minimumValue = 0
//        audioBar.maximumValue = 100 // Percentage
//            
//            if (audioPlayer?.isPlaying)!{
//                playPauseButton.setImage(tintedPauseImage, for: .normal)
//                playPauseButton.tintColor = UIColor.black
//            }
//            
//        }catch { }
//
//            
//            
//        }
//        
        
//        if task?.audioNote != nil {
//            
//            do {
//                try audioPlayer = AVAudioPlayer(data: task!.audioNote! as Data)
//                if audioPlayer!.isPlaying == false {
//                    audioPlayer!.play()
//                    playPauseButton.setImage(tintedPauseImage, for: .normal)
//                    playPauseButton.tintColor = UIColor.black
//                    
//                    print ("hey")
//                    
//                } else if audioPlayer!.isPlaying == true {
//                    print ("YO!")
//                    audioPlayer!.pause()
//                    playPauseButton.setImage(tintedPlayImage, for: .normal)
//                    playPauseButton.tintColor = UIColor.black
//                    
//                }
//
//                
//            } catch {}
//                
//        }
//            
//        else {
//           
//            
//            
//            do {
//                try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
//                if audioPlayer!.isPlaying == false {
//                    self.audioPlayer!.play()
//                    playPauseButton.setImage(tintedPauseImage, for: .normal)
//                    playPauseButton.tintColor = UIColor.black
//                    print ("hey")
//                    
//                } }catch {}
//        
//        
//                do {
//                try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
//                
//                if audioPlayer!.isPlaying == true {
//                    self.audioPlayer!.stop()
//                    playPauseButton.setImage(tintedPlayImage, for: .normal)
//                    playPauseButton.tintColor = UIColor.black
//                    print ("YO!")
//                }
//
//                }catch {}
//
//        }
//        
    
    }
    
    
    
    
    
    
//    @IBAction func playAudio(sender: AnyObject) {
//        playPauseButton.isSelected = !(playPauseButton.isSelected)
//        if playButton.selected {
//            
//            
//            updater = CADisplayLink(target: self, selector: #selector(CreateTaskViewController.trackAudio))
//            updater.preferredFramesPerSecond = 1
//            updater.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
//           // let fileURL = NSURL(string: toPass)
//            audioPlayer = AVAudioPlayer(contentsOf: audioURL, error: nil)
//            audioPlayer?.numberOfLoops = -1 // play indefinitely
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.delegate = self
//            audioPlayer?.play()
//            //startTime.text = "\(player.currentTime)"
//            audioBar.minimumValue = 0
//            audioBar.maximumValue = 100 // Percentage
//        } else {
//            audioPlayer.stop()
//        }
//    }
    
//    func updateTime() {
//        var currentTime = Int(audioPlayer?.currentTime)
//        var duration = Int(audioPlayer?.duration)
//        var total = currentTime - duration
//        var totalString = String(total)
//        
//        var minutes = currentTime/60
//        var seconds = currentTime - minutes / 60
//        
//    }
    
    
    @IBAction func scrubAudio(sender: AnyObject) {
        audioPlayer?.stop()
        audioTime = TimeInterval(audioBar.value)
        audioPlayer?.currentTime = audioTime!
       

       
//        audioPlayer?.prepareToPlay()
//        audioPlayer?.play()
    }
    
    func updatePlayImage() {
        
        if audioPlayer?.isPlaying == false
        {
            let origPlayImage = UIImage(named: "Play Filled-50.png")
            let tintedPlayImage = origPlayImage?.withRenderingMode(.alwaysTemplate)
            playPauseButton.setImage(tintedPlayImage, for: .normal)
            playPauseButton.tintColor = UIColor.darkGray
            toggleState = 1
            audioTime = TimeInterval(audioBar.value)
            audioPlayer?.currentTime = audioTime!
            recordStopButton.isEnabled = true
        }
        
    }
    
    func updateTime() {
        var currentTime = Int((audioPlayer?.currentTime)!)
        var duration = Int((audioPlayer?.duration)!)
        var total = currentTime - duration
        var totalString = String(total)
        var totalMinutes = duration/60
        var totalSeconds = duration - totalMinutes/60
        var minutes = currentTime/60
        var seconds = currentTime - minutes / 60
       
        playedTimer = NSString(format: "%02d:%02d / %02d:%02d", minutes,seconds, totalMinutes, totalSeconds) as String
        
       
        
        playedTime.text = playedTimer
    
    }
    
    func recordingInProgress() {
        
        if (audioRecorder?.isRecording)! {
            audioBar.isHidden = true
            playedTime.isHidden = true
            recordingMessage.isHidden = false
        } else {
            audioBar.isHidden = false
            playedTime.isHidden = false
            recordingMessage.isHidden = true
        }
        
        if recordingMessage.text == "Recording in progress . . . . ." {
            recordingMessage.text = "Recording in progress"
        } else if recordingMessage.text == "Recording in progress"{
            recordingMessage.text = "Recording in progress ."
        } else if recordingMessage.text == "Recording in progress ."{
            recordingMessage.text = "Recording in progress . ."
        } else if recordingMessage.text == "Recording in progress . ." {
            recordingMessage.text = "Recording in progress . . ."
        } else if recordingMessage.text == "Recording in progress . . ." {
            recordingMessage.text = "Recording in progress . . . ."
        } else if recordingMessage.text == "Recording in progress . . . ." {
            recordingMessage.text = "Recording in progress . . . . ."
        }

        
        
        
    }

    
    func updateSlider() {
        audioBar.value = Float((audioPlayer?.currentTime)!)
    }
    
    
    func trackAudio() {
        let normalizedTime = Float((audioPlayer?.currentTime)! * 100.0 / updater.duration)
        audioBar.value = normalizedTime
    }
    
//    @IBAction func cancelClicked(sender: AnyObject) {
//        player.stop()
//        updater.invalidate()
//        dismissViewControllerAnimated(true, completion: nil)
//        
//    }
    
 
    
    func determineTintOfTask() {
       
        if selectedCategory?.color == UIColor.white {
            
            didItButton.tintColor = UIColor.darkGray
            cancelButton.tintColor = UIColor.darkGray
            audioNoteButton.tintColor = UIColor.darkGray
            importantButton.tintColor = UIColor.darkGray
            dueDateButton.tintColor = UIColor.darkGray
             addButton.tintColor = UIColor.darkGray
            undoButton.tintColor = UIColor.darkGray
            deleteButton.tintColor = UIColor.darkGray
            
            
        } else if selectedCategory?.color == UIColor(colorLiteralRed: 255/200, green: 255/255, blue: 102/255, alpha: 1) {
            didItButton.tintColor = UIColor.darkGray
            cancelButton.tintColor = UIColor.darkGray
            audioNoteButton.tintColor = UIColor.darkGray
            importantButton.tintColor = UIColor.darkGray
            dueDateButton.tintColor = UIColor.darkGray
            addButton.tintColor = UIColor.darkGray
            undoButton.tintColor = UIColor.darkGray
            deleteButton.tintColor = UIColor.darkGray
            
        } else {
          
            didItButton.tintColor = UIColor.white
            cancelButton.tintColor = UIColor.white
            audioNoteButton.tintColor = UIColor.white
            addButton.tintColor = UIColor.white
            
            importantButton.tintColor = UIColor.white
            dueDateButton.tintColor = UIColor.white
            undoButton.tintColor = UIColor.white
            deleteButton.tintColor = UIColor.white
            
        }

        
        
        
        
    
    }
    
    
   
    
    }
    






