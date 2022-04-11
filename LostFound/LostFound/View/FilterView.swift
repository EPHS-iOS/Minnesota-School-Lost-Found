//
//  FilterView.swift
//  LostFound
//
//  Created by 90305906 on 3/30/22.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var model: ItemModel
    
    
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Sort By", selection: $model.enteredSort) {
                            ForEach(model.sortTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section {
                        Toggle("T-Shirt", isOn: $model.showTShirt)
                        Toggle("Sweatshirt", isOn: $model.showSweatshirt)
                        Toggle("Shorts", isOn: $model.showShorts)
                        Toggle("Pants", isOn: $model.showPants)
                        Toggle("Hat", isOn: $model.showHat)
                        Toggle("Water Bottle", isOn: $model.showWaterBottle)
                        Toggle("Jewelry", isOn: $model.showJewelry)
                        Toggle("Other", isOn: $model.showOther)
                    }
                }
                Button {
                    model.sortData(sortBy: model.enteredSort)
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Show Results")
                }.frame(width: 250, height: 25)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    
                
            }.toolbar {
                ToolbarItemGroup {
                    Button {
                        model.filterReset()
                    } label: {
                        Text("Reset")
                    }
                }
            }
                .navigationTitle("Add Item")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
//    var filteredSearchResult: [Item] {
//        return model.searchResults.filter { _ in if showTShirt { model.items.type.contains("t-shirt") } || if showSweatshirt { $0.type.contains("sweatshirt") } }
//    }
    
    func filteredSearchResults() {
        
    }
    
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
