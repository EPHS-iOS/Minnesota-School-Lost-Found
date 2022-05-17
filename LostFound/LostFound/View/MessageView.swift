//
//  MessageView.swift
//  LostFound
//
//  Created by 90305906 on 4/11/22.
//

import SwiftUI

struct MessageView: View {
    
    @EnvironmentObject var model : ItemModel
    
    var body: some View {
        
        VStack{
            List(model.messages, id: \.self) { msg in
                HStack {
                    Text(msg.username)
                    Spacer()
                    Text("\(msg.message)")
                }
            }.refreshable {
                DispatchQueue.main.async {
                    model.requestPermission()
                    model.fetchMessages()
                    model.fetchRecordID()
                }
            }
            HStack{
                TextField("Enter Text", text: $model.enteredText)
                Button {
                    model.sendMessage(text: model.enteredText)
                    model.enteredText = ""
                } label: {
                    Label("send", systemImage: "paperplane")
                        .labelStyle(IconOnlyLabelStyle())
                }.disabled(model.username == "")
            }
        }.navigationBarHidden(true)
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
