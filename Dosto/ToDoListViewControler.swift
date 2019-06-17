//
//  ViewController.swift
//  Dosto
//
//  Created by Vidhur Savyasachin on 6/16/19.
//  Copyright © 2019 Vidhur Savyasachin. All rights reserved.
//

import UIKit

class ToDoListViewControler: UITableViewController{
let itemArray = ["Study Datastructures","iOS","100 day programming"]
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
}

