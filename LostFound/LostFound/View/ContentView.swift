//
//  ContentView.swift
//  LostFound
//
//  Created by 90305906 on 5/18/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab : Tab = .home
    @EnvironmentObject var model: ItemModel
    
    var body: some View {
        ZStack (alignment: .bottom) {
            switch selectedTab {
            case .home:
                StudentAllView()
            case .explore:
                StudentAllView()
            case .user:
                StudentAllView()
            case .library:
                StudentAllView()
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}
