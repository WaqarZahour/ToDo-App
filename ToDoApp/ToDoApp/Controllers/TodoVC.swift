//
//  ViewController.swift
//  ToDoApp
//
//  Created by Waqar Zahour on 10/4/17.
//  Copyright © 2017 Waqar Zahour. All rights reserved.
//

import UIKit
import RealmSwift

class TodoVC: UIViewController {

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
        todos = todos?.sorted(byKeyPath: CREATED_DATE, ascending: false)
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
                destination.delegate = self
            }
        }
    }
    
    // MARK: Button Actions
    /// This function called when user press on the + button
    ///
    /// - Parameters
    ///     sender: pass button reference
    @IBAction func addNewTask(_ sender: Any) {
        performSegue(withIdentifier: Identifier.DetailVC.rawValue, sender: nil)
    }
    
    /// In this fucntions when segment change the value sort todos accordingly
    ///
    /// - Parameters
    ///     sender: pass segemented control reference
    @IBAction func segmentChange(_ sender: AnyObject) {
        let filter = Filter(rawValue: segment.selectedSegmentIndex)
        switch filter {
        case .CreatedDate:
            todos = todos?.sorted(byKeyPath: CREATED_DATE, ascending: false)
        case .Priority:
            todos = todos?.sorted(byKeyPath: PRIORITY, ascending: true)
        default:
            break
        }
        tableView.reloadData()
    }
}

extension TodoVC: UITableViewDelegate, UITableViewDataSource {
    
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
}

extension TodoVC: UISearchBarDelegate {
    
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
}

extension TodoVC: DBObjectModiy{
    func refreshUI() {
        self.tableView.reloadData()
    }
}