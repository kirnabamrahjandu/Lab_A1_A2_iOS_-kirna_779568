//
//  ItemDetailViewController.swift
//  Lab_A1_A2_iOS_-kirna_779568
//
//  Created by Kirnaon 19/09/21.
//  Copyright © 2021 Kirnaon. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemProviderLabel: UILabel!
    @IBOutlet weak var itemDescLAbel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemIDLabel: UILabel!
    @IBOutlet weak var itemHearderLabel: UILabel!
    
      var item : Item!
    override func viewDidLoad() {
        super.viewDidLoad()
        itemHearderLabel.text = item.itemName ?? ""
        itemDescLAbel.text = item.itemDescription ?? ""
        itemPriceLabel.text = "$ \(item.itemCost)"
        itemNameLabel.text = item.itemName ?? ""
        itemProviderLabel.text = item.itemProvider ?? ""
        itemIDLabel.text = "\(item.itemId)"
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
