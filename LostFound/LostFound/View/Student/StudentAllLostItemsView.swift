//
//  StudentAllLostItemsView.swift
//  LostFound
//
//  Created by 90305906 on 3/26/22.
//

import SwiftUI

struct StudentAllLostItemsView: View {
    
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
                                NavigationLink(destination: AdminIndividualItemView(item: item), label: {
                                    Image(uiImage: item.image!)
                                        .resizable()
                                        .frame(width: geo.size.width/3, height: geo.size.width/3)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                    
                                })
                                
                            }
                        }
                    }
                }.navigationTitle("Lost Items")
                    .navigationBarTitleDisplayMode(.automatic)
                
            }
        }.navigationViewStyle(.stack)
            .environmentObject(model)
            .navigationBarHidden(true)
    }
}

struct StudentAllLostItemsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentAllLostItemsView()
    }
}
