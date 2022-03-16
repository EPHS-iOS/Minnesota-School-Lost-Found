//
//  ItemModel.swift
//  Lost & Found
//
//  Created by 90305906 on 3/15/22.
//

import Foundation

class ItemModel : ObservableObject {
    @Published var items = [Item]()
    
   // Using this init for test items before adding items is added.
    init() {
        items.append(Item(image: "bed.double.fill", title: "Hydroflask", addedDate: "03/15/2022", isClaimed: false, description: "blue and white"))
        items.append(Item(image: "tram.fill", title: "Hydroflask", addedDate: "03/15/2022", isClaimed: false, description: "blue and white"))
        items.append(Item(image: "tv.music.note.fill", title: "Hydroflask", addedDate: "03/15/2022", isClaimed: false, description: "blue and white"))
        items.append(Item(image: "hare.fill", title: "Hydroflask", addedDate: "03/15/2022", isClaimed: false, description: "blue and white"))
    }
}
