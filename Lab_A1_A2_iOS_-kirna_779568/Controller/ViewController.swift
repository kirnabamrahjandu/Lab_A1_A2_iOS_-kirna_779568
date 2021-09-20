//
//  ViewController.swift
//  Lab_A1_A2_iOS_-kirna_779568
//
//  Created by Kirna 19/09/21.
//  Copyright © 2021 Kirna. All rights reserved.
//


import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    var productArray: [Item] = []
    let dataManager = CoreDataManager.shared
    var item : Item!
    var context : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBtn.frame.size.height = 50
        self.addBtn.frame.size.width = 50
        self.addBtn.frame.origin.y = self.view.frame.size.height - 80
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllProductsList()
        self.navigationController?.navigationBar.backgroundColor = .clear
        
    }
    @IBAction func addProductBtn(_ sender: Any) {
        let vc : AddItemViewController = self.storyboard?.instantiateViewController(identifier: "AddItemViewController") as! AddItemViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController{
    
    func getAllProductsList() {
        
        let managedContext = dataManager.persistentContainer.viewContext
        let req: NSFetchRequest<Item> = Item.fetchRequest()
        
        if searchBar.text?.count ?? 0 > 0{
            req.predicate = NSPredicate(format: "itemName contains[cd] %@ OR itemDescription contains[cd] %@", searchBar.text ?? "", searchBar.text ?? "")
        }
        do {
            productArray = try managedContext.fetch(req)
            
            self.tblView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

// MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.getAllProductsList()
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let product = productArray[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.textLabel?.text = product.itemName ?? ""
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let item = productArray[indexPath.row]
            let vc : ItemDetailViewController = self.storyboard?.instantiateViewController(identifier: "ItemDetailViewController") as! ItemDetailViewController
            vc.item = item
            self.navigationController?.pushViewController(vc, animated: true)
    }
    // Override to support editing the table view.
    
//     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            let i = indexPath.row
//            productArray.remove(at: i)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//     }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // action one
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { [self] (action, indexPath) in
            print("Edit tapped")
            
            let item = productArray[indexPath.row]
            let vc : ItemDetailViewController = self.storyboard?.instantiateViewController(identifier: "ItemDetailViewController") as! ItemDetailViewController
            vc.item = item
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        })
        editAction.backgroundColor = UIColor.blue
        
        // action two
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            // Delete the row from the data source
            let i = indexPath.row
            let toDelete = self.productArray[i]
            print(toDelete.itemName!)
            self.productArray.remove(at: i)
            
//            // remove from database
//            self.context.delete(toDelete)
//            do {
//                try self.context.save()
//                print("Deleted!")
//            }
//            catch {
//                print("error while commiting delete")
//            }
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }
}
