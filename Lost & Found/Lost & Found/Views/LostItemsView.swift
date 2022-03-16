//
//  LostItemsView.swift
//  Lost & Found
//
//  Created by 90305906 on 3/15/22.
//

import SwiftUI

struct LostItemsView: View {
    
    @ObservedObject var model = ItemModel()
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading){
                
                ScrollView{
                    GeometryReader{ geo in
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 3 ){
                            ForEach(model.items, id: \.self){ item in
                                NavigationLink(destination: IndividualItemView(item: item), label: {
                                    Image(systemName: item.image)
                                        .frame(width: geo.size.width/3, height: geo.size.width/3)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                    
                                })
                                
                            }
                        }
                    }
                }.navigationTitle(Text("Lost Items"))
                    .navigationBarTitleDisplayMode(.automatic)
                
                
            }
        }.navigationViewStyle(.stack)
    }
}

struct LostItemsView_Previews: PreviewProvider {
    static var previews: some View {
        LostItemsView()
    }
}
