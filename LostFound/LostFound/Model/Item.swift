//
//  Item.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import Foundation

struct Item : Identifiable, Hashable {
    var id = UUID()
    //image is currently a String for testing. will mostly likely need to be switched back to Image once image importing is used
    var image : String
    var title : String
    //may make addedDate a Date too, using String for testing
    var addedDate : String
    var isClaimed : Bool
    var name : String
    var description : String
}
