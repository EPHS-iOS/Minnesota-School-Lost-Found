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
                }
            
            MessageView()
                .tabItem() {
                    Image(systemName: "message.circle")
                    Text("Message")
                }

            SettingsView()
                .tabItem() {
                    Image(systemName: "gear.circle")
                    Text("Settings")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        AdminTabView()
    }
}
