//
//  ContentView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct ContentView: View {
    // Copy of LostItemsView here to view for testing
    @StateObject var model = ItemModel()
    

    
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
//                    .onAppear {
//                        model.items = model.items
//                    }
                NavigationLink(destination: AddLostItemView(), label: { Text("Add item") })
            }
        }.navigationViewStyle(.stack)
            .environmentObject(model)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

