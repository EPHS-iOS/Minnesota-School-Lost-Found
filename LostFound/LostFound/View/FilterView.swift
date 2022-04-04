//
//  FilterView.swift
//  LostFound
//
//  Created by 90305906 on 3/30/22.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var model = ItemModel()
    @StateObject var filter = FilterModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Sort By", selection: $filter.enteredSort) {
                            ForEach(filter.sortTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section {
                        Toggle("T-Shirt", isOn: $filter.showTShirt)
                        Toggle("Sweatshirt", isOn: $filter.showSweatshirt)
                        Toggle("Shorts", isOn: $filter.showShorts)
                        Toggle("Pants", isOn: $filter.showPants)
                        Toggle("Hat", isOn: $filter.showHat)
                        Toggle("Water Bottle", isOn: $filter.showWaterBottle)
                        Toggle("Jewelry", isOn: $filter.showJewelry)
                        Toggle("Other", isOn: $filter.showOther)
                    }
                }
                Button {
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
                        filter.filterReset()
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
