
import UIKit

class todoListViewController: UITableViewController {
    
    var items = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        let newItem1 = Item()
//        newItem1.title = "bunburder"
//        items.append(newItem1)
//
//        let newItem2 = Item()
//        newItem2.title = "sun-bun"
//        items.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "find jerry"
//        items.append(newItem3)
        
//        if let itemArray = defaults.array(forKey: "TodoListArray") as? [String] {
//            items = itemArray
//        }
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
            
            let newItem = Item()
            newItem.title = textFiled.text!
            
            self.items.append(newItem)
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
       let encoder = PropertyListEncoder()
                   
       do {
        let data = try encoder.encode(items)
           try data.write(to: dataFilePath!)
       } catch {
           print("error is \(error)")
       }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                items = try decoder.decode([Item].self, from: data)
            } catch {
                print(error)
            }
        }
    }
}

