
import UIKit

class todoListViewController: UITableViewController {
    
    var items = ["cake with cream", "milk of cow", "falling song"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let itemArray = defaults.array(forKey: "TodoListArray") as? [String]{
            items = itemArray
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        return cell
    }
    
    
    
    @IBAction func barButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "add new todoey item", message: "", preferredStyle: .alert)
        var textFiled = UITextField()
        
        alert.addAction(UIAlertAction(title: "add item", style: .default) { (action) in
            
            self.items.append(textFiled.text!)
            
            self.defaults.set(self.items, forKey: "TodoListArray")
           
            self.tableView.reloadData()
        })
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textFiled = alertTextField
        }
        
        present(alert,animated: true, completion: nil)
    }

}

