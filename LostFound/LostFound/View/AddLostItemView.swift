//
//  AddLostItemView.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import SwiftUI

struct AddLostItemView: View {
    
    @EnvironmentObject var itemModel: ItemModel
    
    @State private var enteredTitle : String = ""
    @State private var enteredDescription : String = ""
    @State private var enteredName : String = ""
    
    
    var body: some View {
        
        VStack {
            Text("Item lost")
            TextField("Item Lost", text: $enteredTitle)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("Does it have a name on it?")
            TextField("Name", text: $enteredName)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("Description")
            TextField("Description", text: $enteredDescription)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            Button {
                itemModel.addItem(image: "tram.fill", title: enteredTitle, addedDate: "03/16/2022", isClaimed: false, name: enteredName, description: enteredDescription)
            } label: {
                Text("Add Item")
            }

        }
    }
}

struct AddLostItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddLostItemView()
    }
}
