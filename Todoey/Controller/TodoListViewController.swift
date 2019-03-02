//
//  ViewController.swift
//  Todoey
//
//  Created by Prateek Rao on 3/1/19.
//  Copyright © 2019 Prateek Rao. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [ToDoItem]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = ToDoItem()
        newItem.name = "Do CS homework"
        itemArray.append(newItem)
        
        let newItem2 = ToDoItem()
        newItem2.name = "Read CS 161 notes"
        itemArray.append(newItem2)
        
        let newItem3 = ToDoItem()
        newItem3.name = "Do CS 178 project"
        itemArray.append(newItem3)
        
        let newItem4 = ToDoItem()
        newItem4.name = "Do LJ20 homework"
        itemArray.append(newItem4)
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [ToDoItem]{
            itemArray = items
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Tableview Datasource Methods
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        print(cell.textLabel?.text)
        
        cell.accessoryType =  item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(itemArray.count)
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //Flip the bool value "done"
        
        tableView.reloadData() //Call the datasource methods again
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
    /* Interestingly, if I replace the logic of the conditional with one opposite, i.e check for none and set to checkmark, Xcode doesn't understand that .none is an accessory. Alternatively, we can do this by using UITableViewCell.AccessoryType.none instead of .none
         */
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var itemTextField = UITextField()
        
        let alert = UIAlertController(title: "Add New To-Do item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add item button on our UIAlert
            if itemTextField.text != ""{
                
                let newItem = ToDoItem()
                newItem.name = itemTextField.text!
                
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "TodoListArray")
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            itemTextField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}

