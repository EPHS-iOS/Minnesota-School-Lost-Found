//
//  ContentView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct AdminAllLostItemsView: View {
    
    @StateObject var model = ItemModel()
    
    @State private var showingAddItem = false
    
    
    
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
//                NavigationLink(destination: AddLostItemView(), label: { Text("Add item") })
                
            }.toolbar {
                ToolbarItemGroup {
                    Button  {
                        showingAddItem.toggle()
                    } label: {
                        Label {
                            Text("Add Item")
                        } icon: {
                            Image(systemName: "plus")
                        }

                    }
                    .popover(isPresented: $showingAddItem) {
                        AddLostItemView()
                    }
                }
            }
        }.navigationViewStyle(.stack)
            .environmentObject(model)
            .navigationBarHidden(true)
    }
}

struct AdminAllLostItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAllLostItemsView()
    }
}







