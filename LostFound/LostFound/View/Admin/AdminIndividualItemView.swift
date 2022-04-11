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
    @StateObject var model = ItemModel()
    
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
//            if let intVal = isClaimed, let boolVal = (intVal != 0) {
//                Text(boolVal ? "Yes" : "No")
//            }
            //Text(model.isClaimed)
            Text(item.description)
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
                            itemModel.deleteItem(input: item)
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
