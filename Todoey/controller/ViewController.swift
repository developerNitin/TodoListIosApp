//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Nitin Birdi on 02/05/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import CoreData

class todoListViewController: UITableViewController {
    
    var items = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }
    
    //MARK: - Tableview method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].title
        cell.accessoryType = items[indexPath.row].done ? .checkmark : .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(items[indexPath.row])
//        items.remove(at: indexPath.row)
        
        items[indexPath.row].done = !items[indexPath.row].done
        
        self.saveItem()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Bar Button method
    
    @IBAction func barButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "add new todoey item", message: "", preferredStyle: .alert)
        var textFiled = UITextField()
        
        alert.addAction(UIAlertAction(title: "add item", style: .default) { (action) in
            
           
            let newItem = Item(context: self.context)
            newItem.title = textFiled.text!
            self.items.append(newItem)
            
            newItem.done = false
            self.saveItem()
            self.tableView.reloadData()
        })
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "create new item"
            textFiled = alertTextField
        }
       present(alert,animated: true, completion: nil)
    }
    
    //MARK: - Add new items
    
    func saveItem() {
       do {
         try context.save()
       } catch {
         print("error unresolved (saving context) \(error)")
        }
    }
    
    
    func loadItems(request: NSFetchRequest <Item> = Item.fetchRequest()) {
        do {
            items = try context.fetch(request)
        } catch {
            print("fetch error \(error)")
        }
    }
}

//MARK: - Search bar method

extension todoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(request: request)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
