//
//  ViewController.swift
//  MarijnHop-pset4
//
//  Created by Marijn Hop on 22/11/2016.
//  Copyright © 2016 Marijn Hop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    @IBAction func addButton(_ sender: UIButton) {
        textField.becomeFirstResponder()
    }
    
    // Database
    private let db = DatabaseHelper()
    
    // Array for tasks
    var tasks = [String]()

    // Add task with the return key when textfield is not empty
    @IBAction func addTask(_ sender: UITextField) {
        if textField.text != ""{
            do {
                try db!.createRow(task: textField.text!)
                tasks = try db!.read()
                textField.text = ""
                tableView.reloadData()
            } catch {
                print("Error adding task")
            }
        }
        // Hide keyboard
        view.endEditing(true)
    }
    
    // Delete task
    func deleteTask(task:String?) {
        
        do {
            try db!.deleteRow(task: task!)
        } catch {
            print("Error deleting task")
        }
    }
    
    // Edit to-do list
    @IBAction func editList(_ sender: UIBarButtonItem) {
        
        // Change text in edit button
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            editButton.title = "Edit"
        } else{
            tableView.setEditing(true, animated: true)
            editButton.title = "Done"
        }
        // Hide keyboard while editing
        view.endEditing(true)
    }
    
    // Load to-do list on startup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        do {
            tasks = try db!.read()
            
        } catch {
            print("Error loading tasks")
        }
    }
}


// Tableview Delegate & Datasource
extension ViewController: UITableViewDataSource {
    
    // Return number of tasks
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // Make new cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ToDoCell
     
        cell.taskLabel.text = tasks[indexPath.row]
     
        return cell
    }
    
    // Delete task when swiping left
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            deleteTask(task: tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // Support for rearranging tasks
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ViewController: UITextFieldDelegate {
}
