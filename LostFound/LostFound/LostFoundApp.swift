//
//  LostFoundApp.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

@main
struct LostFoundApp: App {
    @StateObject var globalVar = globalVariable()
    var body: some Scene {
        WindowGroup {
            //AdminAllLostItemsView()
            //AdminTabView()
            //LoginView()
            //CloudUser()
            if globalVar.loginViewChange{
                LoginView().environmentObject(globalVar)

            }else{
                AnimationStart().environmentObject(globalVar)
            }
        }
        
    }
}

