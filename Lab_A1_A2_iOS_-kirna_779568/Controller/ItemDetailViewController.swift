//
//  ItemDetailViewController.swift
//  Lab_A1_A2_iOS_-kirna_779568
//
//  Created by Kirna 19/09/21.
//  Copyright © 2021 Kirna. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemProviderLabel: UILabel!
    @IBOutlet weak var itemDescLAbel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemIDLabel: UILabel!
    @IBOutlet weak var itemHearderLabel: UILabel!
    
    var item : Item!
    var context:NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
        
        itemHearderLabel.text = item.itemName ?? ""
        itemDescLAbel.text = item.itemDescription ?? ""
        itemPriceLabel.text = "\(item.itemCost)"
        itemNameLabel.text = item.itemName ?? ""
        itemProviderLabel.text = item.itemProvider ?? ""
        itemIDLabel.text = "\(item.itemId)"
       // itemProviderLabel.text = "abcd"
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    //MARK:- Alert
    func SHOW_ALERT_CONTROLLER_DOUBLE_BUTTON(alertTitle:String, message:String, btnTitle1:String, btnTitle2:String,viewController:UIViewController,  completionHandler:@escaping (String) -> ())
    {
        let alert = ALERT_CONTROLLER(title: alertTitle, message: message)
        let cancelAction = ALERT_CONTROLLER_CANCEL_ACTION(title: btnTitle1) { (success) in
            completionHandler("Button1")
        }
        alert.addAction(cancelAction)
        
        let okAction = ALERT_CONTROLLER_OK_ACTION(title: btnTitle2) { (success) in
            completionHandler("Button2")
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    func ALERT_CONTROLLER(title: String, message : String) -> UIAlertController {
        return  UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    }

    func ALERT_CONTROLLER_CANCEL_ACTION(title:String, completionHandler:@escaping (Bool) -> ()) -> UIAlertAction {
        return  UIAlertAction(title: title, style: UIAlertAction.Style.cancel, handler:{                                          UIAlertAction in
            completionHandler(true)
        })
    }

    func ALERT_CONTROLLER_OK_ACTION(title:String, completionHandler:@escaping (Bool) -> ()) -> UIAlertAction {
        return  UIAlertAction(title: title, style: UIAlertAction.Style.default, handler:{                                          UIAlertAction in
            completionHandler(true)
        })
    }
}
