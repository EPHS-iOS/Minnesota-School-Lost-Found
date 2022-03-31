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
    //@StateObject var filter = FilterModel()
    
    @State var enteredSort: String = "Date- New to Old"
    private var sortTypes: [String] = ["Date- New to Old", "Date- Old to New"]
    @State var showTShirt = true
    @State var showSweatshirt = true
    @State var showShorts = true
    @State var showPants = true
    @State var showHat = true
    @State var showWaterBottle = true
    @State var showJewelry = true
    @State var showOther = true
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section {
                        Picker("Sort By", selection: $enteredSort) {
                            ForEach(sortTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section {
                        Toggle("T-Shirt", isOn: $showTShirt)
                        Toggle("Sweatshirt", isOn: $showSweatshirt)
                        Toggle("Shorts", isOn: $showShorts)
                        Toggle("Pants", isOn: $showPants)
                        Toggle("Hat", isOn: $showHat)
                        Toggle("Water Bottle", isOn: $showWaterBottle)
                        Toggle("Jewelry", isOn: $showJewelry)
                        Toggle("Other", isOn: $showOther)
                    }
                }
                Button {
                    
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
                        enteredSort = "Date- New to Old"
                        showTShirt = true
                        showSweatshirt = true
                        showShorts = true
                        showPants = true
                        showHat = true
                        showWaterBottle = true
                        showJewelry = true
                        showOther = true
                        //filter.reset()
                    } label: {
                        Text("Reset")
                    }
                }
            }
                .navigationTitle("Add Item")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
//    var filteredSearchResults: [Item] {
//        return model.searchResults.filter { _ in if showTShirt { model.items.type.contains("t-shirt") } || if showSweatshirt { $0.type.contains("sweatshirt") } }
//    }
    
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
