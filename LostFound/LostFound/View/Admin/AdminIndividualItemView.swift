//
//  AdminIndividualItemView.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import SwiftUI

struct AdminIndividualItemView: View {
    
    var item: Item
    @EnvironmentObject var model : ItemModel
    
    var body: some View {
        ScrollView {
        VStack {
            
            //Text(item.title)
                //.font(.title)
            ZStack {
                Rectangle()
                    .fill(Color.cyan)
                    .frame(width: 350, height: 100)
                    .cornerRadius(30)
                  
        
                HStack {
                    Text("Expires in: ")
                        .font(.title)
                    //make this a var
                    Text("00")
                        font(.title)
                    Text(" days")
                    Image("calendar1")
                
                }
            }
         
            if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 300)
                    .border((LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .bottom, endPoint: .top)), width: 4)
            }
//            if let intVal = isClaimed, let boolVal = (intVal != 0) {
//                Text(boolVal ? "Yes" : "No")
//            }
            VStack {
                Text("Description: ")
                    
                Text(item.description)
            }
           
            Button {
                model.claimItem(item: item)
                //model.isClaimed = item.isClaimed
            } label: {
                Text("Claim Item")
            }.frame(width: 250, height: 25)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
            
        }.navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItemGroup {
                    HStack {
                        Button {
                            model.showingEditItem.toggle()
                        } label: {
                            Label {
                                Text("Edit")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                            
                        }.popover(isPresented: $model.showingEditItem) {
                            EditLostItemView(item: item)
                        }
                        Button {
                            model.deleteItem(input: item)
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
            .onAppear {
                model.isClaimed = item.isClaimed
            }
        }
    }
}
