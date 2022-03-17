//
//  ItemModel.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import Foundation
import UIKit
import SwiftUI

class ItemModel : ObservableObject {
    @Published var items = [Item]()
    

    
    func addItem(image: UIImage?, title: String, addedDate: String, isClaimed: Bool, name: String, description: String) {
        items.append(Item(image: image, title: title, addedDate: addedDate, isClaimed: isClaimed, name: name, description: description))
    }
    
}
