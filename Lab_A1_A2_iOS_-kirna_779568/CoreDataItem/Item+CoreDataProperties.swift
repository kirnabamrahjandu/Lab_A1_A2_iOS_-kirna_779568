//
//  Item+CoreDataProperties.swift
//  Lab_A1_A2_iOS_-kirna_779568
//
//  Created by Kirna 19/09/21.
//  Copyright © 2021 Kirna. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var itemId: Int32
    @NSManaged public var itemName: String?
    @NSManaged public var itemDescription: String?
    @NSManaged public var itemCost: Float
    @NSManaged public var itemProvider: String?

}
