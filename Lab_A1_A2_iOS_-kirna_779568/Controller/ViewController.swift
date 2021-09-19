//
//  ViewController.swift
//  Lab_A1_A2_iOS_-kirna_779568
//
//  Created by Kirnaon 19/09/21.
//  Copyright © 2021 Kirnaon. All rights reserved.
//


import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    var productArray: [Item] = []
    let dataManager = CoreDataManager.shared
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAllProductsList()
        self.navigationController?.navigationBar.backgroundColor = .clear
        
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

}
