//
//  MessageView.swift
//  LostFound
//
//  Created by 90305906 on 4/11/22.
//

import SwiftUI

struct MessageView: View {
    
    @StateObject var model = ItemModel()
    
    var body: some View {
        
        VStack{
            List {
                Text("Messages here")
            }
            HStack{
                TextField("Enter Text", text: $model.enteredText)
                Button {
                    model.sendMessage(text: model.enteredText)
                    model.enteredText = ""
                } label: {
                    Label("send", systemImage: "paperplane")
                        .labelStyle(IconOnlyLabelStyle())
                }
            }
        }
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
