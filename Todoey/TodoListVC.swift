//
//  ViewController.swift
//  Todoey
//
//  Created by Nirbhay Singh on 18/09/18.
//  Copyright © 2018 Nirbhay Singh. All rights reserved.
//

import UIKit

class TodoListVC: UITableViewController {
    var item = ["Study Add. Math","Study Int. Math","Study Physics","Study Computer Science"]
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [String]{
            item = items
        }
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text=item[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(item[indexPath.row])
        if( tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add new item", message:"", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            print("Success")
            print(textfield.text!)
            if (textfield.text!==""){
                let alert = UIAlertController(title: "Error", message: "Please input some values", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .destructive, handler: nil))
                self.present(alert,animated: true)
            }else{
                print(self.item)
                self.item.append(textfield.text!)
                print(self.item)
                self.defaults.setValue(self.item, forKey: "TodoListArray")
                self.tableView.reloadData()
            }
         
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Enter a new item..."
            textfield = alertTextField
            print(alertTextField.text!)
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
}

