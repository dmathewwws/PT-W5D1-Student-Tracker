//
//  TableViewController.swift
//  PT-W5D1-Parse
//
//  Created by Daniel Mathews on 2016-02-02.
//  Copyright © 2016 Daniel Mathews. All rights reserved.
//

import Foundation
import UIKit
import Parse

class TableViewController : UITableViewController {
    
    
    var students = [Student]()
    var textField = UITextField()
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add a Student", message: "", preferredStyle: .Alert)
        
        let OKaction = UIAlertAction(title: "OK", style: .Default) { (alert) -> Void in
            
            let student = Student(name: self.textField.text!)
            student.saveInBackgroundWithBlock({ (success, error) -> Void in
                if success{
                    print("You have successfully added \(self.textField.text!) to Parse")
                }
            })
            
            self.students.append(student)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive) { (alert) -> Void in
            
        }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            self.textField = textField
        }

        alertController.addAction(OKaction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        
        let query = Student.query()
        query?.whereKey("name", containsString: "a")
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if let students = objects as? [Student]{
                self.students = students
                self.tableView.reloadData()
            }
        })
        
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("studentCell", forIndexPath: indexPath)
        
        let student = students[indexPath.row]
        
        cell.textLabel?.text = student.name
        return cell
    }
    
}