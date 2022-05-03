//
//  MenuView.swift
//  LostFound
//
//  Created by 64008786 on 4/11/22.
//

import SwiftUI

struct StudentTabView: View {
    var body: some View {
        TabView {
            StudentAllLostItemsView()
                .tabItem() {
                    Image(systemName: "house.circle")
                    Text("Items")
                }.padding()
            
            MessageView()
                .tabItem() {
                    Image(systemName: "message.circle")
                    Text("Message")
                }.padding()

            SettingsView()
                .tabItem() {
                    Image(systemName: "gear.circle")
                    Text("Settings")
                }.padding()
            
        }//.tabViewStyle(PageTabViewStyle())
        .navigationBarBackButtonHidden(true)
    }
    
}


struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        StudentTabView()
    }
}

