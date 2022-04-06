//
//  ContentView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct StudentAllLostItemsView: View {
    
    @StateObject var model = ItemModel()
    @State private var logout = false
    
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
                            ForEach(model.searchResults, id: \.self){ item in
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
                    HStack {
                        Button {
                            model.showingFilter.toggle()
                        } label: {
                            Label {
                                Text("Filter")
                            } icon: {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                            }
                            
                        }.popover(isPresented: $model.showingFilter) {
                            FilterView()
                        }
                    }
                }
                
            }
           
            
            
        }.navigationViewStyle(.stack)
            .environmentObject(model)
            .navigationBarHidden(true)
            .searchable(text: $model.searchText)
        NavigationLink(destination: LoginView(), isActive: $logout) {
            Text("Logout")
                .onTapGesture {
                    self.logout = true
                }
        }.navigationBarHidden(true)
        
    }
}
struct StudentAllLostItemsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentAllLostItemsView()
    }
}
