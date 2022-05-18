//
//  testtabview.swift
//  LostFound
//
//  Created by 90305906 on 5/3/22.
//

import SwiftUI

struct testtabview: View {
    
    var item: Item
    @StateObject var model = ItemModel()
   
    
    var body: some View {
        
        TabView {
            ForEach(model.items.indices) { i in
                let chosen = model.items.first(where: {$0.id == item.id})
                let index = model.items.firstIndex(of: chosen!)
                AdminIndividualItemView(item: item)
            }
        }.tabViewStyle(.page(indexDisplayMode: .never))
        
        
    }
}

