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
    @State var searchText = ""
    @State var isSearching = false
    @State var showResults = false
    @State var loadSearch = false
    
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading){
                
                
                HStack {
                    SearchView(searchText: $searchText, isSearching: $isSearching, showResults: $showResults, loadSearch: $loadSearch)
                        
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                    .padding([.top, .bottom, .trailing])
                    .frame(width: 3.0, height: 3.0)

                }.padding(.top, 8)
                    .padding(.bottom, 2)
                
                ScrollView{
                    
                    GeometryReader{ geo in
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 3 ){
                            ForEach(model.items.filter({ searchText.isEmpty ? true : $0.title.contains(searchText) }), id: \.self){ item in
                                NavigationLink(destination: AdminIndividualItemView(item: item), label: {
                                    Image(uiImage: item.image!)
                                        .resizable()
                                        .frame(width: geo.size.width/3, height: geo.size.width/3)
                                        .background(Image(systemName: "photo")
                                                        .foregroundColor(.white)
                                                        .frame(width: geo.size.width/3, height: geo.size.width/3)
                                                        .background(Color.gray))
                                        .foregroundColor(.white)
                                })
                            }
                        }
                    }
                }.navigationTitle("Lost Items")
                    .navigationBarTitleDisplayMode(.automatic)
                
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
                    }.popover(isPresented: $showingAddItem) {
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







