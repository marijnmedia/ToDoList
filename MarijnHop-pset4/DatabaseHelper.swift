//
//  DatabaseHelper.swift
//  MarijnHop-pset4
//
//  Created by Marijn Hop on 22/11/2016.
//  Copyright © 2016 Marijn Hop. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    // Database
    private var db: Connection?
    
    // Table
    private let ToDoList = Table("ToDoList")
    
    // Columns
    private let id = Expression<Int64>("id")
    private let tasks = Expression<String?>("tasks")
    
    // Initialize database
    init?() {
        do {
            try setupDatabase()
        } catch {
            print(error)
            return nil
        }
    }
    
    // Setup database
    private func setupDatabase() throws {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            db = try Connection("\(path)/db.sqlite3")
            try createTable()
        } catch {
            throw error
        }
    }
    
    // Create table
    private func createTable() throws {
        
        do {
            try db!.run(ToDoList.create(ifNotExists: true) {
                t in
                
                t.column(id, primaryKey: .autoincrement)
                t.column(tasks)
                print("Table created")
            })
        } catch {
            throw error
        }
        
    }
    
    // Create row
    func createRow(task: String) throws {
        let insert = ToDoList.insert(tasks <- task)
        
        do {
            let rowid = try db!.run(insert)
            print("Row \(rowid) created")
        } catch {
            throw error
        }
        
    }
    
    /// Delete row
    func deleteRow(task: String) throws {
        
        let deleteRow = ToDoList.filter(tasks == task)
        
        do {
            let numberOfRowsDeleted = try db!.run(deleteRow.delete())
            print(numberOfRowsDeleted, "row(s) deleted \nTask: \(task)")
        } catch {
            throw error
        }
        
    }
    
    /// Read from table
    func read() throws -> Array<String> {
        
        var AllTasks = [String]()
        
        do {
            for row in try db!.prepare(ToDoList) {
                AllTasks.append(row[tasks]!)
            }
        } catch {
            throw error
        }
        return AllTasks
    }
    
}
