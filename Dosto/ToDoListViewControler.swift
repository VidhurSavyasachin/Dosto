//
//  ViewController.swift
//  Dosto
//
//  Created by Vidhur Savyasachin on 6/16/19.
//  Copyright © 2019 Vidhur Savyasachin. All rights reserved.
//

import UIKit

class ToDoListViewControler: UITableViewController{
   
    var itemArray = ["iOS"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
     
        return cell
        
    }
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.itemArray[indexPath.row])
      
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
      
    }
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New DoEto item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //once add is presssed
            
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
        
      
        }
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create New Item"
            textField = alertTextFeild
            print("now")
            
        }
        alert.addAction(action)
        
        present(alert, animated: true,completion: nil)
    }
}

