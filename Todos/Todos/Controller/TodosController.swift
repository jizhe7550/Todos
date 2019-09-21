//
//  TodosController.swift
//  Todos
//
//  Created by Joe on 20/09/19.
//  Copyright © 2019 Joe. All rights reserved.
//

import UIKit

class TodosController: UITableViewController {
    
    var todos = [
        Todo(name: "coding C#", checked: false),
        Todo(name: "coding Java", checked: false),
        Todo(name: "coding Dart", checked: false),
        Todo(name: "coding swift", checked: false)
    ]
    
    var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
     // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! TodoCell

        // Configure the cell...
        cell.todo.text = todos[indexPath.row].name
        cell.checkMark.text = todos[indexPath.row].checked ? "√" : ""
 
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //change model
        todos[indexPath.row].checked = !todos[indexPath.row].checked
        //change view
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        cell.checkMark.text = todos[indexPath.row].checked ? "√" : ""
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addTodo" {
            let vc = segue.destination as! TodoController
            vc.delegate = self
        } else if segue.identifier == "editTodo" {
            let vc = segue.destination as! TodoController
            let cell = sender as! TodoCell
            row = tableView.indexPath(for: cell)!.row
            vc.name = todos[row].name
            vc.delegate = self
        }
    }
 

}

extension TodosController : TodoDelegate{
    func didEdit(name: String) {
        //model
        todos[row].name = name
        //view
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! TodoCell
        cell.todo.text = name
    }
    
    func didAdd(name: String) {
        //model
        todos.append(Todo(name: name, checked: false))
        //view
        let indexPath = IndexPath(row: todos.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
}
