//
//  ItemStruct.swift
//  Lab_A1_A2_iOS_-kirna_779568
//
//  Created by Kirna 19/09/21.
//  Copyright © 2021 Kirna. All rights reserved.
//

import Foundation

struct ItemStruct : Codable {
    let itemId : Int16?
    let itemName : String?
    let itemDescription : String?
    let itemCost : Float?
    let itemProvider : String?

    enum CodingKeys: String, CodingKey {

        case itemId = "itemId"
        case itemDescription = "itemDescription"
        case itemName = "itemName"
        case itemCost = "itemCost"
        case itemProvider = "itemProvider"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try values.decodeIfPresent(Int16.self, forKey: .itemId)
        itemName = try values.decodeIfPresent(String.self, forKey: .itemName)
        itemDescription = try values.decodeIfPresent(String.self, forKey: .itemDescription)
        itemCost = try values.decodeIfPresent(Float.self, forKey: .itemCost)
        itemProvider = try values.decodeIfPresent(String.self, forKey: .itemProvider)
    }

}
