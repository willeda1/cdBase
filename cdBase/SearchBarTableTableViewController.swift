//
//  SearchBarTableTableViewController.swift
//  cdBase
//
//  Created by David Wille on 04/01/2019.
//  Copyright © 2019 David Wille. All rights reserved.
//

import UIKit
import CoreData

class SearchBarTableTableViewController: UITableViewController {
    
    private let appDelegate=UIApplication.shared.delegate as! AppDelegate
    private let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request = NSFetchRequest<Person>(entityName:"Person")
    lazy var frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func save(){
        appDelegate.saveContext()
    }
    
    func updateFrc(filter : String? = nil){
        
        save()
        
        if let filter = filter {
            frc.fetchRequest.predicate=NSPredicate(format:"name CONTAINS[c] %@",filter)
        } else {
            frc.fetchRequest.predicate=nil
        }
        
        do {
            try frc.performFetch()
        } catch {
            print("whoops - FRC updated failed")
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType=UITextAutocapitalizationType.none
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // from https://stackoverflow.com/questions/48361507/uisearchcontroller-not-shown
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        request.sortDescriptors=[NSSortDescriptor(key: "date", ascending: true)]
        frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        updateFrc()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        guard let sections = frc.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath)
        
        // Configure the cell...
        
        if let label = cell.viewWithTag(1000) as? UILabel {
            let person = frc.object(at: indexPath)
            label.text=person.name
        }
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = frc.object(at: indexPath)
            context.delete(person)
            updateFrc()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let fromObj=frc.object(at: fromIndexPath)
        let toObj=frc.object(at: to)
        let temp=fromObj.date
        fromObj.date=toObj.date
        toObj.date=temp
        do {try context.save()}
        catch {print("could not save")}
        updateFrc()
    }
    
    
    
}

// MARK: this is new

extension SearchBarTableTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    
    func updateSearchResults(for searchController: UISearchController) {
        let text=searchController.searchBar.text!
        
        if text.isEmpty {
            updateFrc()
        } else {
            updateFrc(filter:text)
        }
    }
}
