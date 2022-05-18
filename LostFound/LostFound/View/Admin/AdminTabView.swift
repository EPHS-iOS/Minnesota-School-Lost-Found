////
////  MenuView.swift
////  LostFound
////
////  Created by 90305906 on 4/11/22.
////
//
//import SwiftUI
//
//struct AdminTabView: View {
//
//
//
//    var body: some View {
//
//        NavigationView {
//            TabView {
//                AdminAllLostItemsView().environmentObject(model).navigationBarHidden(true)
//                    .tabItem() {
//                        Image(systemName: "house.circle")
//                        Text("Items")
//                    }.padding()
//                    .navigationBarHidden(true)
//
//
//                MessageView().environmentObject(model).navigationBarHidden(true)
//                    .tabItem() {
//                        Image(systemName: "message.circle")
//                        Text("Message")
//                    }.padding()
//                    .navigationBarHidden(true)
//
//
//                SettingsView().environmentObject(model).navigationBarHidden(true)
//                    .tabItem() {
//                        Image(systemName: "gear.circle")
//                        Text("Settings")
//                    }.padding()
//                    .navigationBarHidden(true)
//
//            }.navigationTitle("")
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
//
//        }.navigationTitle("")
//        .navigationBarHidden(true)
//    }
//}
//struct AdminTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdminTabView()
//    }
//}
