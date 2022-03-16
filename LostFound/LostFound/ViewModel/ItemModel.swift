//
//  ItemModel.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import Foundation

class ItemModel : ObservableObject {
    @Published var items = [Item]()
    
   // Using this init for test items before adding items is added.
    init() {
        items.append(Item(image: "bed.double.fill", title: "Hydroflask", addedDate: "03/15/2022", isClaimed: false, name: "max", description: "blue and white"))
        items.append(Item(image: "tram.fill", title: "Hydroflask", addedDate: "03/15/2022", isClaimed: false, name: "lucas", description: "blue and white"))
        items.append(Item(image: "tv.music.note.fill", title: "Hydroflask", addedDate: "03/15/2022", isClaimed: false, name: "ariel", description: "blue and white"))
        items.append(Item(image: "hare.fill", title: "Hydroflask", addedDate: "03/15/2022", isClaimed: false, name: "hello", description: "blue and white"))
    }
    
    func addItem(image: String, title: String, addedDate: String, isClaimed: Bool, name: String, description: String) {
        items.append(Item(image: image, title: title, addedDate: addedDate, isClaimed: isClaimed, name: name, description: description))
    }
    
}
