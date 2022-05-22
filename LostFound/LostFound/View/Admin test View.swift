//
//  AdminAllLostItemsView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct StudentAllView: View {
    
    
    @State var hasScrolled = false
    @Namespace var namespace
    @State var show = false
    @State var showStatusBar = true
    @State var selectedId = UUID()
    @EnvironmentObject var model : ItemModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        
        
        ZStack {
            
            
            
            ScrollView {
                scrollDetection
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 3 ){
                    items
                }
                
                
            }.coordinateSpace(name: "scroll")
                .safeAreaInset(edge: .top, content: {
                    Color.clear
                        .frame(height: 70)
                })
                .overlay(
                    NavigationBar(title: "Lost & Found", hasScrolled: $hasScrolled)
                )
            
            
            if show {
                individualItem
            }
        }
        
        
    }
    
    var scrollDetection: some View {
        GeometryReader { proxy in
            //Text("\(proxy.frame(in: .named("scroll")).minY)")
            Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeInOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
    }
    
    var items: some View {
        ForEach(model.searchResults, id: \.self){ item in
            
            if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                    .onTapGesture {
                            show.toggle()
                            model.showDetail.toggle()
                            showStatusBar = false
                            selectedId = item.id
                    }
                    .background(Image(systemName: "photo")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                        .background(Color.gray))
                    .foregroundColor(.white)
            }
        }
    }
    
    var individualItem: some View {
        ForEach(model.searchResults, id: \.self) { item in
            if item.id == selectedId {
                AdminIndividualItemView(item: item, show: $show)
                    .zIndex(1)
            }
        }
    }
    
    
}





