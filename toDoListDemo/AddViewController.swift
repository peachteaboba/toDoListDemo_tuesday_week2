//
//  AddViewController.swift
//  toDoListDemo
//
//  Created by Andy Feng on 4/18/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var doneAddingTaskDelegate: DoneAddingTaskDelegate?
    

    // Outlets
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var dateField: UIDatePicker!
    
    
    @IBAction func handleAddButtonPressed(_ sender: UIButton) {
        
        print("add button pressed")
        
        // Add to core data
        
        let newTask = NSEntityDescription.insertNewObject(forEntityName: "Tasks", into: context) as! Tasks
        
        // Set Attributes
        newTask.title = titleField.text
        newTask.desc = descField.text
        newTask.date = dateField.date as NSDate
        newTask.checked = false
        
        // Save
        if context.hasChanges {
            do {
                try context.save()
                print("We just saved a new task. Now it's time to go back to the MainTVC!")
                
                /// Go back (Delegte)
                doneAddingTaskDelegate?.doneAdding()
                
                
                
                
            } catch {
                print("\(error)")
            }
        }
        
        
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    

}
