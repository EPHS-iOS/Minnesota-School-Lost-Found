//
//  IndividualItemView.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import SwiftUI

struct IndividualItemView: View {
    
    var item: Item
    
    var body: some View {
        VStack {
            Text(item.title)
                .font(.title)
            Text(item.addedDate, format: .dateTime.day().month())
            Image(uiImage: item.image!)
                .resizable()
                .frame(height: 300)
        }.navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.automatic)
    }
}
