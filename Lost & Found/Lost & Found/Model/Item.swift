//
//  Item.swift
//  Lost & Found
//
//  Created by 90305906 on 3/15/22.
//

import Foundation
import SwiftUI

struct LostItem {
    var id : UUID
    var image : Image
    var title : String
    var addedDate : Date
    var isClaimed : Bool
}
