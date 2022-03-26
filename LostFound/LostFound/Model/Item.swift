//
//  Item.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import Foundation
import UIKit

struct Item : Identifiable, Hashable {
    
    var id = UUID()
    var image : UIImage?
    var title : String
    //may make addedDate a Date too, using String for testing
    var addedDate : Date
    var isClaimed : Bool
    var name : String
    var description : String
}
