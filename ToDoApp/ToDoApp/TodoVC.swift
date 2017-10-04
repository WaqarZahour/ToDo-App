//
//  ViewController.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import UIKit
import RealmSwift
class TodoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // MARK: IBOoutlet and Other Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var todos: Results<Todo>?
    var isSearchMode = false
    
    // MARK: View Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        todos = DataLayer.instance.getAll()
        todos = todos?.sorted(byKeyPath: DATE_CREATED, ascending: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    /// In a storyboard-based application, you will often want to do a little preparation before navigation
    ///
    /// - Parameters:
    ///   - segue: to navigate from one screen to antother
    ///   - sender: is todo object
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.DetailVC.rawValue {
            if let destination = segue.destination as? DetailVC {
                if let todo = sender as? Todo {
                    destination.todo = todo
                }
            }
        }
    }
    
    // MARK: TableView Delegate and Datasource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.TodoCell.rawValue, for: indexPath) as! TodoCell
        cell.configureCell(todo: (self.todos?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let todos = todos {
            return todos.count
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifier.DetailVC.rawValue, sender: (self.todos?[indexPath.row])!)
    }
    
    // MARK: SearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearchMode = false
            todos = DataLayer.instance.getAll()
            tableView.reloadData()
            view.endEditing(true)
        } else {
            isSearchMode = true
            let searchText = searchBar.text!.lowercased()
            todos = DataLayer.instance.filterByName(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    // MARK: Button Actions
    /// In this fucntions when segment change the value sort todos accordingly
    ///
    /// - Parameters
    ///     sender: pass button reference
    @IBAction func segmentChange(_ sender: AnyObject) {
        if segment.selectedSegmentIndex == 0 {
            todos = todos?.sorted(byKeyPath: DATE_CREATED, ascending: false)
        } else if segment.selectedSegmentIndex == 1 {
            todos = todos?.sorted(byKeyPath: PRIORITY, ascending: true)
        }
        tableView.reloadData()
        
    }
}

