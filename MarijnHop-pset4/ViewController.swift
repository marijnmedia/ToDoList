//
//  ViewController.swift
//  MarijnHop-pset4
//
//  Created by Marijn Hop on 22/11/2016.
//  Copyright © 2016 Marijn Hop. All rights reserved.
//

import UIKit
// import SQLite


class ViewController: UIViewController {
    
    var tasks = [String]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    

    @IBAction func addTask(_ sender: UITextField) {
        if textField.text != ""{
            tasks.append(textField.text!)
            textField.text = ""
            tableView.reloadData()
        }
        
        view.endEditing(true)
    }
    
    @IBAction func editList(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            editButton.title = "Edit"
        } else{
            tableView.setEditing(true, animated: true)
            editButton.title = "Done"
        }
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }

}


//MARK: - Tableview Delegate & Datasource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ToDoCell
     
        cell.taskLabel.text = tasks[indexPath.row]
     
        return cell
    }
    
     // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
    return true
    }
    
     // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            tasks.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
     // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code
    }
}

extension ViewController: UITextFieldDelegate {
}
