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
    @StateObject var model = ItemModel()
    var body: some Scene {
        WindowGroup {
            //ContentView().environmentObject(model)
            //AdminAllView().environmentObject(model)
            StudentFeaturedView().environmentObject(model)
            //StudentAllView().environmentObject(model)
//            if globalVar.loginViewChange{
//                LoginView().environmentObject(globalVar)
//
//            }else{
//                AnimationStart().environmentObject(globalVar)
//            }
        }
        
    }
}

