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
    var addedDate : Date
    var isClaimed : Bool
    var type : String
    var description : String
    var tags : [String]
}
