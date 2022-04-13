//
//  MenuView.swift
//  LostFound
//
//  Created by 90305906 on 4/11/22.
//

import SwiftUI

struct AdminTabView: View {
    var body: some View {
        TabView {
            AdminAllLostItemsView()
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
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTabView()
    }
}
