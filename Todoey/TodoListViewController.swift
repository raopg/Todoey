//
//  ViewController.swift
//  Todoey
//
//  Created by Prateek Rao on 3/1/19.
//  Copyright © 2019 Prateek Rao. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Do CS homework", "Apply for internships", "Register for classes", "Apply to HackSC 19"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Tableview Datasource Methods
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
    /* Interestingly, if I replace the logic of the conditional with one opposite, i.e check for none and set to checkmark, Xcode doesn't understand that .none is an accessory. Alternatively, we can do this by using UITableViewCell.AccessoryType.none instead of .none
         */
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    


}

