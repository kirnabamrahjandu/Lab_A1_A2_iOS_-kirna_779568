//
//  ViewController.swift
//  Lab_A1_A2_iOS_-kirna_779568
//
//  Created by Kirna 20/09/21.
//  Copyright © 2021 Kirna. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController,UITextViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var itemPriceLabel: UITextField!
    @IBOutlet weak var itemProviderLabel: UITextField!
    @IBOutlet weak var itemDescLAbel: UITextView!
    @IBOutlet weak var itemNameLabel: UITextField!
    @IBOutlet weak var itemIDLabel: UITextField!
    var productArray: [Item] = []
    let dataManager = CoreDataManager.shared
    var item : Item!
    var context : NSManagedObjectContext!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
        itemDescLAbel.delegate = self
        itemDescLAbel.text = "Enter Product Description"
        itemDescLAbel.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: Any) {
        // create a new note in the notebook
        self.item = Item(context:context)
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: "\(itemPriceLabel.text ?? "")")
        let numberFloatValue = number?.floatValue
        item.itemCost = numberFloatValue!
        item.itemDescription = itemDescLAbel.text
        item.itemProvider = itemProviderLabel.text
        let numberID = numberFormatter.number(from: "\(itemIDLabel.text ?? "")")
        let numberIDFloatValue = numberID?.floatValue
        item.itemId = Int32(numberIDFloatValue!)
        item.itemName = itemNameLabel.text
        
        do {
            try context.save()
            // show an alert box
            SHOW_ALERT_CONTROLLER_DOUBLE_BUTTON(alertTitle: "Saved!", message: "Save Successfully", btnTitle1: "Cancle", btnTitle2: "OK", viewController: self, completionHandler:{ (response) in
                if(response == "Button2"){
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        catch {
            print("Error saving note in Edit Note screen")
            
            // show an alert box with an error message
            let alertBox = UIAlertController(title: "Error", message: "Error while saving.", preferredStyle: .alert)
            alertBox.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertBox, animated: true, completion: nil)
        }
        
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
    //MARK:- UITextfield delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter description"
            textView.textColor = UIColor.lightGray
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
