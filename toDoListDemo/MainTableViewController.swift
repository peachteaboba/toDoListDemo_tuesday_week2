//
//  MainTableViewController.swift
//  toDoListDemo
//
//  Created by Andy Feng on 4/18/17.
//  Copyright © 2017 Andy Feng. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, DoneAddingTaskDelegate {

    // MARK: Global Variables ::::::::::::::::::::::::::::::::::::::::::::
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasksArr = [Tasks]()
    
    
    
    
    // MARK: UI Lifecycle ::::::::::::::::::::::::::::::::::::::::::::::::
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        getAllData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: Core Data Methods ::::::::::::::::::::::::::::::::::::::::::
    func getAllData(){
        
        // Fetch data from Core Data
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        
        do {
            // get the results by executing the fetch request we made earlier
            let results = try context.fetch(itemRequest)
            
            // downcast the results as an array of Tasks objects
            tasksArr = results as! [Tasks]
            
            for t in tasksArr {
                print(t.title ?? "nil")
            }
            
            tableView.reloadData()
            
        } catch {
            // print the error if it is caught (Swift automatically saves the error in "error")
            print("\(error)")
        }
        
    }
    
    
    
    
    
    
    // MARK: Table View Functions :::::::::::::::::::::::::::::::::::::::
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TaskTableViewCell
        
        cell.model = tasksArr[indexPath.row]
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tasksArr[indexPath.row].checked {
            // uncheck it
            tasksArr[indexPath.row].checked = false
        } else {
            // check it
            tasksArr[indexPath.row].checked = true
        }
        
        // Save the changed to core data
        // Save
        if context.hasChanges {
            do {
                try context.save()
                print("Toggled Checkmark!")
                
                getAllData()
                
            } catch {
                print("\(error)")
            }
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    // MARK: Protocol Functions :::::::::::::::::::::::::::::::::::::::::
    func doneAdding() {
        
        self.navigationController?.popViewController(animated: true)
        
        getAllData()
        
    }
    
    
    // MARK: Segue Function :::::::::::::::::::::::::::::::::::::::::::::
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! AddViewController
        vc.doneAddingTaskDelegate = self
        
        
    }
    
    
    
    
    

}

