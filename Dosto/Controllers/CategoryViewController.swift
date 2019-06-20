//
//  CategoryViewController.swift
//  Dosto
//
//  Created by Vidhur Savyasachin on 6/19/19.
//  Copyright © 2019 Vidhur Savyasachin. All rights reserved.
//

import UIKit
import CoreData
class CategoryViewController: UITableViewController {
    
    var CategoryArray = [Category]()
    
    //creating context will initialize the container called as presistent container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catgoryIdentifier",for: indexPath)
        let item = CategoryArray[indexPath.row]
        cell.textLabel?.text = item.name
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "go_to_item" , sender: self)
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewControler
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = CategoryArray[indexPath.row]
        }
        
        
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(CategoryArray[indexPath.row])
            self.CategoryArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category   ", style: .default) { (action) in
            let newItem = Category(context: self.context)
            if(textField.text!.isEmpty){
                newItem.name = "New Item"
            }else{
            newItem.name = textField.text!
            }
                self.CategoryArray.append(newItem)
            
            self.saveCategories()
            
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true,completion: nil)
    }
    func saveCategories(){
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
     
        do{
            CategoryArray = try context.fetch(request)
        }catch{
            print("Error fetching data from the context \(error)")
        }
        tableView.reloadData()
    }
    
}
