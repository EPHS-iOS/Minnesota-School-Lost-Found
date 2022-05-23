//
//  AdminAllLostItemsView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct StudentAllView: View {
    
    @Namespace var namespace
    @State var showStatusBar = true
    @State var selectedId = UUID()
    @EnvironmentObject var model : ItemModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var navTitle: String {
        if model.selectedCategory.isEmpty {
            return "Lost & Found"
        } else {
            return model.selectedCategory
        }
    }
    
    
    var body: some View {
        //NavigationView {
        
        ZStack {
            
            Image("Background-2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.8)
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
                            .frame(height: model.navHeight)
                    })
                    .overlay(
                        StudentNavBarView(title: navTitle, pic: "xmark", isHome: false, hasScrolled: $model.hasScrolled)
                    )
                
                    .navigationBarHidden(true)
            
            
            
            if model.showInd {
                individualItem
            }
        }
    //}.searchable(text: $model.searchText, placement: .navigationBarDrawer(displayMode: .always))
        
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
                        model.showInd.toggle()
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
                StudentItemView(item: item, show: $model.showInd)
                    .zIndex(1)
            }
        }
    }
    
    
}





