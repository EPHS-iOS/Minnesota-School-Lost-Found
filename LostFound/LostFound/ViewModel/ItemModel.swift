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
    

    
    func addItem(image: UIImage?, title: String, addedDate: Date, isClaimed: Bool, description: String, tags: [String]) {
        items.append(Item(image: image, title: title, addedDate: addedDate, isClaimed: isClaimed, description: description, tags: tags))
    }
    
    func claimItem(id: UUID) {
        if let item = items.first(where: {$0.id == id}) {
            let index = items.firstIndex(of: item)
            
            items[index!].isClaimed = true
        }
    }
    
    func editItem(id: UUID, image: UIImage?, title: String, isClaimed: Bool, description: String) {
        if let item = items.first(where: {$0.id == id}) {
            let index = items.firstIndex(of: item)
            
            items[index!].image = image
            items[index!].title = title
            items[index!].isClaimed = isClaimed
            items[index!].description = description
        }
    }
    
    func deleteItem(id: UUID) {
        if let item = items.first(where: {$0.id == id}) {
            let index = items.firstIndex(of: item)
         
            items.remove(at: index!)
        }
    }
    
    func findTags(searchText: String) {
        var indexes : [Int] = []
        for i in 0..<items.count {
            if items[i].tags.contains(searchText) {
                indexes.append(i)
            }
        }
    }
    
    
}
