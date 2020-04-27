
import UIKit
import CoreData

class todoListViewController: UITableViewController {
    
    var items = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
    }
    
    
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
        
        items[indexPath.row].done = !items[indexPath.row].done
        
        self.saveItem()
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
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
    
    
    func saveItem() {
                   
       do {
         try context.save()
       } catch {
         print("error unresolved (saving context) \(error)")
       }
    }
    
    func loadItems() {
        let element: NSFetchRequest <Item> = Item.fetchRequest()
        do {
            items = try context.fetch(element)
        } catch {
            print("fetch error \(error)")
        }
    }
}

