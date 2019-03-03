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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoItems.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(dataFilePath)
        
        
        loadItems()
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [ToDoItem]{
//            itemArray = items
//        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Tableview Datasource Methods
    
    //TODO: Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        cell.accessoryType =  item.done == true ? .checkmark : .none
        
        return cell
    }
    
    //TODO: Declare numberOfRowsInSection here:
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //Flip the bool value "done"
        
        self.saveItems()
        
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
                
                self.saveItems()
                
                 
                
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
    
    //MARK - Model Manipulation Methods
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        
        } catch {
            print("Error encoding item array: \(error)")
        }
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([ToDoItem].self, from: data)
            } catch {
                print("error decoding the data")
            }
        }
    }
    

}

