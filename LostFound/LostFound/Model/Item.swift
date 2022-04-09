//
//  Item.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import Foundation
import UIKit
import CloudKit

struct Item : Identifiable, Hashable {
    
    var id = UUID()
    var image : URL?
    var title : String
    //var addedDate : Date
    var isClaimed : Int64
    var type : String
    var description : String
    //var tags : [String]
    var record : CKRecord
}
