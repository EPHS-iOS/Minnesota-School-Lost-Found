//
//  AdminAllLostItemsView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct AdminAllView: View {
    
    
    @Namespace var namespace
    @State var showStatusBar = true
    @State var selectedId = UUID()
    @EnvironmentObject var model : ItemModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        
        
        ZStack {
            
            Image("Background-1")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.4)
                .mask(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0.8), Color.black.opacity(0.8), Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(20)
                .offset(y: -UIScreen.main.bounds.height / 4.5)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
            
            
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
                    AdminNavBarView(title: "Lost & Found", hasScrolled: $model.hasScrolled)
                )
            
            
            if model.showInd {
                individualItem
            }
        }.navigationBarHidden(true)
        
        
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
                    model.hasScrolled = true
                } else {
                    model.hasScrolled = false
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
                        model.selectedId = item.id
                        model.showDetail.toggle()
                        showStatusBar = false
                        model.showInd.toggle()
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
            if item.id == model.selectedId {
                AdminItemView(item: item, show: $model.showInd)
                    .zIndex(1)
            }
        }
    }
    
    
}


