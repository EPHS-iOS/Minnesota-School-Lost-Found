//
//  TabView.swift
//  LostFound
//
//  Created by 90305906 on 5/18/22.
//

import SwiftUI

struct TabBar: View {
    @AppStorage("selectedTab") var selectedTab : Tab = .home
    @State var color: Color = .teal
    @State var tabItemWidth : CGFloat = 0
    
    var body: some View {
        ZStack (alignment: .bottom){
            
            HStack {
                buttons
            }
            .padding(.horizontal, 8)
            .padding(.top, 14)
            .frame(height: 88, alignment: .top)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 34, style: .continuous))
            .strokeStyle(cornerRadius: 34)
            .background(
                    background
            )
            .overlay(
                overlay
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.all)
            
        }
    }
    
    var buttons: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation (.spring(response: 0.3, dampingFraction: 0.7)){
                    selectedTab = item.tab
                    color = item.color
                }
            } label: {
                VStack (spacing: 0){
                    Image(systemName: item.icon)
                        .frame(width: 44, height: 29)
                        .symbolVariant(.fill)
                        .font(.body.bold())
                    Text(item.text)
                        .font(.caption2)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
            }
            .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
            .blendMode(selectedTab == item.tab ? .overlay : .normal)
            .overlay {
                GeometryReader { proxy in
                    Color.clear.preference(key: TabPreferenceKey.self, value: proxy.size.width)
                }
            }
            .onPreferenceChange(TabPreferenceKey.self) { value in
                tabItemWidth = value
            }
        }
    }
    
    var background: some View {
        HStack {
            //if selectedTab == .library { Spacer() }
            if selectedTab == .explore { Spacer() }
            if selectedTab == .user {
                Spacer()
                Spacer()
            }
            Circle().fill(color).frame(width: tabItemWidth)
            if selectedTab == .explore {
                //Spacer()
                Spacer()
            }
            if selectedTab == .user {  }
            if selectedTab == .home { Spacer() }
        }
        .padding(.horizontal, 8)
    }
    
    var overlay: some View {
        HStack {
            //if selectedTab == .library { Spacer() }
            if selectedTab == .explore { Spacer() }
            if selectedTab == .user {
                Spacer()
                Spacer()
            }
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .frame(width: 25, height: 5)
                .frame(width: tabItemWidth)
                .foregroundColor(color)
                .frame(maxHeight: .infinity, alignment: .top)
            if selectedTab == .explore {
                //Spacer()
                Spacer()
            }
            if selectedTab == .user {  }
            if selectedTab == .home { Spacer() }
        }
            .padding(.horizontal, 8)
    }
}
