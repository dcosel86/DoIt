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
   
    
    
   
    //outlets
    
    
    @IBOutlet weak var addAudioNoteButton: UIButton!
    
    
    @IBOutlet weak var playRecordView: UIView!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    @IBOutlet weak var importantSwitch: UISwitch!
    
    @IBOutlet weak var notesTextField: UITextView!
    
    @IBOutlet weak var dateFieldText: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var createTaskView: CreateTaskView!

    @IBOutlet weak var didItButton: UIButton!
    
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBOutlet weak var recordStopButton: UIButton!
    
    
    
    //functions
    
    override func viewDidLoad() {
        UINavigationBar.appearance().barTintColor = UIColor.lightGray
        
        
        createTaskView.layer.cornerRadius = 10
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        UINavigationBar.appearance().tintColor = UIColor.white
        
        
        super.viewDidLoad()
        self.categoryPicker.dataSource = self;
        self.categoryPicker.delegate = self;
        self.taskNameTextField.delegate = self;
        //self.notesTextField.delegate = self;
        playPauseButton.isEnabled = false
        
        getCategories()
        getTasks()
    
        
    
        
        //load date picker
        datePickerView.datePickerMode = UIDatePickerMode.date
        //datePickerView.minimumDate = date
        dateFieldText.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(CreateTaskViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        datePickerView.backgroundColor = UIColor.groupTableViewBackground
       
       
        //load category picker
        categoryTextField.inputView = UIView()
        
        
        
        
        
        if task != nil {
            let dateFromTask = task?.dueDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            let dateToShow = "\(dateFormatter.string(from: dateFromTask as! Date))"
            taskNameTextField.text = task?.taskName
            notesTextField.text = task?.taskNotes
            importantSwitch.isOn = (task?.important)!
            
            dateFieldText.text = dateToShow
            task!.taskPriority = task!.taskPriority
            task?.audioNote = task?.audioNote
            addButton.setTitle("Update", for: .normal)
            addButton.isEnabled = false
            addButton.isHidden = true
            didItButton.isHidden = false
            didItButton.isEnabled = true
            if task?.audioNote != nil {
                playRecordView.isHidden = false
                addAudioNoteButton.isHidden = true
                addAudioNoteButton.isEnabled = false
                setUpRecorder()
            } else {
                playRecordView.isHidden = true
                addAudioNoteButton.isHidden = false
                addAudioNoteButton.isEnabled = true
            }
            if task?.taskCategory != nil {
                categoryTextField.text = "\(task!.taskCategory!.categoryName!)"
                determineIndexOfTaskCategory()
            }else {
                categoryTextField.text = "\(categories[0].categoryName!)"
            }
            
            
            
        
        }
        else {
             addButton.setTitle("Add", for: .normal)
            addButton.isEnabled = false
            addButton.isHidden = false
            didItButton.isHidden = true
            didItButton.isEnabled = false
            playRecordView.isHidden = true
            addAudioNoteButton.isHidden = false
            addAudioNoteButton.isEnabled = true
            if selectedCategory != nil {
                categoryTextField.text = selectedCategory?.categoryName
                determineIndexOfSelectedCategory()
            }else {
            categoryTextField.text = "\(categories[0].categoryName!)"
            }
        }

    }

       
    
    
    override func viewWillAppear(_ animated: Bool) {
      
       categoryPicker.isHidden = true
        
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
        let selectedCategory = (category.categoryName)
        categoryTextField.text = "\(selectedCategory!)"
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
    
    
    
    @IBAction func notesFieldTapped(_ sender: Any) {
        notesTextField.isEditable = true
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
    
    
    @IBAction func impSwitchTapped(_ sender: Any) {
        if task != nil {
             addButton.setTitle("Update", for: .normal)
            addButton.isEnabled = true
            addButton.isHidden = false
            didItButton.isEnabled = false
            didItButton.isHidden = true
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToTasks", sender: self)
    }
    
    
    @IBAction func editDidBegin(_ sender: Any) {
        categoryPicker.isHidden = false
    }
    
    @IBAction func editsEnd(_ sender: Any) {
        categoryPicker.isHidden = true
    }
    
    
    
    
    
    //actions
    
    
    @IBAction func tapOutOfCreate(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToTasks", sender: self)
    }
    
    
    
    
    
    
    @IBAction func didItButtonTapped(_ sender: Any) {
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       task!.completed = true
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        self.performSegue(withIdentifier: "unwindToTasks", sender: self)
        
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
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
                
                
                if audioURL != nil {
                    task2.audioNote = NSData(contentsOf: audioURL!)
                } else {
                    try task2.audioNote? = NSData(contentsOf: audioURL!)
                }

                task2.taskName = taskNameTextField.text
                task2.taskNotes = notesTextField.text
                task2.important = importantSwitch.isOn
                task2.completed = false
                task2.taskPriority = task!.taskPriority
                
                
                task2.dueDate = dateToSave as NSDate?
                
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
            task.important = importantSwitch.isOn
            task.taskNotes = notesTextField.text
            task.completed = false
                
               
            task.dueDate = dateToSave as NSDate?
            task.setValue(category, forKey: "taskCategory")
            task.createdDate = NSDate()
                if audioURL != nil {
            task.audioNote = NSData(contentsOf: audioURL!)
                } else {
                    try task.audioNote? = NSData(contentsOf: audioURL!)
                }
            
            if importantSwitch.isOn {
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
    
   

    
    func setUpRecorder() {
        
        if task != nil {
        playPauseButton.isEnabled = true
        }
        
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
    
    
    @IBAction func addAudioNoteButtonTapped(_ sender: Any) {
        playRecordView.isHidden = false
        addAudioNoteButton.isHidden = true
        addAudioNoteButton.isEnabled = false
        setUpRecorder()
    }
    
    
    @IBAction func deleteAudioNoteButtonTapped(_ sender: Any) {
        playRecordView.isHidden = true
        addAudioNoteButton.isHidden = false
        addAudioNoteButton.isEnabled = true
        
        audioURL = nil
        
    }
    
    

    @IBAction func recordStopTapped(_ sender: Any) {
        if audioRecorder!.isRecording {
            audioRecorder!.stop()
            recordStopButton.setTitle("⏺", for: .normal)
            playPauseButton.isEnabled = true
            addButton.isEnabled = true
            
        } else {
            audioRecorder!.record()
            recordStopButton.setTitle("⏹", for: .normal)
            }
}
    

    
    
    @IBAction func playPauseTapped(_ sender: Any) {
        
        
        if task != nil {
            
            if task?.audioNote != nil{
            
            do {
                try audioPlayer = AVAudioPlayer(data: task!.audioNote! as Data)
            } catch {}
                
            } else if task?.audioNote == nil {
                do {
                    try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
                    audioPlayer!.play()
                } catch {
                    
                }
            }
            
                if audioPlayer!.isPlaying == false {
                    audioPlayer!.play()
                playPauseButton.setTitle("⏸", for: .normal)
                    print("hello")
                } else {
                    audioPlayer!.pause()
                    playPauseButton.setTitle("▶️", for: .normal)
                    print("hi")

            }
            
        }
        
        
        if task == nil {
       
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        } catch {
            
        }
        }
    }
    
    
    

    }
    
   
    
    

