//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Nitin Birdi on 02/05/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategory()
    }
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Data Manipulation Methods
    
    //MARK: - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "add new category", message: "", preferredStyle: .alert)
        var textfield = UITextField()
        
        alert.addAction(UIAlertAction(title: "add category", style: .default, handler: { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textfield.text!
            
            self.categories.append(newCategory)
            self.saveCategory()
            self.tableView.reloadData()
        }))
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "add new category"
            textfield = alertTextField
        }
        
        present(alert,animated: true, completion: nil)
    }
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("error during saving data: \(error)")
        }
    }
    
    func loadCategory(request: NSFetchRequest <Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("error during loaddata: \(error)")
        }
    }
    
    //MARK: - TableView Datasource Methods
    
    //MARK: - TableView Delegate Methods
    
    //MARK: - Data Manipulation Method
}
