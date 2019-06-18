//
//  ViewController.swift
//  Dosto
//
//  Created by Vidhur Savyasachin on 6/16/19.
//  Copyright © 2019 Vidhur Savyasachin. All rights reserved.
//

import UIKit

class ToDoListViewControler: UITableViewController{
   
    var itemArray = [To_do_data]()
      let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask ).first?.appendingPathComponent("Items.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
      

        let newItem = To_do_data()
        newItem.to_do = "Find Mike"
        itemArray.append(newItem)
        let newItem1 = To_do_data()
        newItem1.to_do = "Eat Eggos"
        itemArray.append(newItem1)
        let newItem2 = To_do_data()
        newItem2.to_do = "Kill demogorgan"
        itemArray.append(newItem2)
//        if let items = defaults.array(forKey: "ToDoListArray")
//            as? [To_do_data] {
//            itemArray = items
//        }
        loadItems()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.to_do
        
        cell.accessoryType = item.checked ? .checkmark : .none
        
    
        return cell
        
    }
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
   
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        self.itemArray[indexPath.row].checked = !self.itemArray[indexPath.row].checked
        
       
      self.saveItems()
//        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        tableView.deselectRow(at: indexPath, animated: true)
        
      
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.itemArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New DoEto item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //once add is presssed
            let newItem = To_do_data()
            newItem.to_do = textField.text!
            self.itemArray.append(newItem)
           
          self.saveItems()
            
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")

            
            
        }
        alert.addTextField { (alertTextFeild) in
            alertTextFeild.placeholder = "Create New Item"
            textField = alertTextFeild
            print("now")
            
        }
        alert.addAction(action)
        
        present(alert, animated: true,completion: nil)
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }catch{
            print("ERROR ENCIDUBG ITEM ARRAY \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                
                itemArray = try decoder.decode([To_do_data].self, from: data)
            }catch{
                print("ERROR")
            }
            }
    }
}

