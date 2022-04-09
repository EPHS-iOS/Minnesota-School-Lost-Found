//
//  AdminIndividualItemView.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import SwiftUI

struct AdminIndividualItemView: View {
    
    var item: Item
    @EnvironmentObject var itemModel: ItemModel
    
    var body: some View {
        
        VStack {
            Text(item.title)
                .font(.title)
            Text("Date added: ")
            //Text(item.addedDate, format: .dateTime.day().month())
            
            if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 300)
            }
            
        }.navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        itemModel.deleteItem(id: item.id)
                    } label: {
                        Label {
                            Text("Delete")
                        } icon: {
                            Image(systemName: "trash")
                        }

                    }
                }
            }
    }
}
