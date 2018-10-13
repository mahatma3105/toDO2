//
//  ViewController.swift
//  toDO2
//
//  Created by kamal chibrani on 05/10/18.
//  Copyright © 2018 kamal chibrani. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet{
//            loadItem()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


   // let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        

        
//        if let   items = defaults.array(forKey: "itemArrayList") as? [Item]{
//            itemArray = items
//        }   ***********************************  need to change it later ***************
        
        
        
     //   loadItem()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK:- TableView DataSource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
      cell.accessoryType =  item.done ?  .checkmark :  .none // this code replaces the code below
        
        
//        if item.done ==  true{
//            cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
    }
    
    
    //MARK:- tableview delegate method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        
       // context.delete(itemArray[indexPath.row]) //this will remove item from the context on click
        //itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done //this replaces the code below
        
        saveItem()
        
//        if  itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }
//        else{
//            itemArray[indexPath.row].done = false
//
//        }
        
       // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if         tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark

        }
        
        tableView.reloadData()

        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK:- add new item
    
    @IBAction func addNewItems(_ sender: UIBarButtonItem) {
        
        var addItemTextField = UITextField()
        
        let alert = UIAlertController(title: "add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default) { (action) in
            // what will happen when user will press add new item button
            
            
//            let newItem = Item(context: self.context)
//
//            newItem.title = addItemTextField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            print(addItemTextField.text! )

//            self.itemArray.append(newItem)
//            let encoder = PropertyListEncoder()
//
//            do{
//                    let data = try encoder.encode(self.itemArray)
//                try data.write(to: self.dataFilePath!)
//
//            }
//            catch{
//                print("error in encoder \(error)")
//            }
//
           self.saveItem()
            
            
            
            
            
          //  self.defaults.set(self.itemArray, forKey: "itemArrayList")      deleted
            self.tableView.reloadData()
         //   print(self.itemArray.count)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Item "
            addItemTextField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK:- model manupaltion method
    
    
    
    func saveItem()  {
       
        
        do{
            try context.save()
            
        }
        catch{
            print("error in saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    
//    func loadItem(with request : NSFetchRequest<Item> = Item.fetchRequest() , predicate:NSPredicate? = nil )  {
//
////        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory!.name!))
//        if let additionalPredicate = predicate{
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
//        }else{
//            request.predicate = categoryPredicate
//        }
//        let compundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate!,categoryPredicate])
//        request.predicate = compundPredicate
//
//        do{
//            itemArray =  try context.fetch(request)
//        } catch {
//            print("request made to the database \(error)")
//        }
//
//}
    
    
    
    
  
}

// MARK :- search bar methods

//extension ToDoViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        request.predicate = NSPredicate(format: "title CONTAINS [cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItem(with:  request)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadItem()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//}


