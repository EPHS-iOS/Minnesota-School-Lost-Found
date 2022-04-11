//
//  AdminAllLostItemsView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct AdminAllLostItemsView: View {
    
    @StateObject var model = ItemModel()
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading){
                
                ScrollView{
                   
                    GeometryReader{ geo in
                        Spacer()
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                      
                            GridItem(.flexible()),
                
                            GridItem(.flexible())
                          
                        ], spacing: 6 ){
                            ForEach(model.searchResults, id: \.self){ item in
                                NavigationLink(destination: AdminIndividualItemView(item: item), label: {
                                    
                                    if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                        Image(uiImage: image)
                                            .resizable()
                                            .frame(width: geo.size.width/3, height: geo.size.width/3)
                                            .background(Image(systemName: "photo")
                                                            .foregroundColor(.white)
                                                            .frame(width: geo.size.width/3, height: geo.size.width/3)
                                                            .background(Color.gray))
                                            .foregroundColor(.white)
                                            .border(LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? Color.white: Color.black, Color(red: 161/255, green: 32/255, blue: 22/255)]), startPoint: .bottom, endPoint: .top), width: 4)
                                    }
                                    
                                })
                            }
                        }
                    }
                }.navigationTitle("EPHS Lost & Found")
                    .navigationBarTitleDisplayMode(.automatic)
                    .font(Font.system(size:46, weight: .bold))
                    //.foregroundStyle(LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? Color.white: Color.black, Color(red: 161/255, green: 32/255, blue: 22/255)]), startPoint: .bottom, endPoint: .top))
                
                
                
                    
                
            }.toolbar {
                ToolbarItemGroup {
                    HStack {
                        Image("EPLogoResized")
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
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
                        Button  {
                            model.showingAddItem.toggle()
                        } label: {
                            Label {
                                Text("Add Item")
                            } icon: {
                                Image(systemName: "plus")
                            }
                        }.popover(isPresented: $model.showingAddItem) {
                            AddLostItemView()
                        }
                    }
                }
            }
            
            
        }.navigationViewStyle(.stack)
            .environmentObject(model)
            .navigationBarHidden(true)
            .searchable(text: $model.searchText)
            
        
    }
}

struct AdminAllLostItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAllLostItemsView()
    }
}







