//
//  StudentFeaturedView.swift
//  LostFound
//
//  Created by 90305906 on 5/19/22.
//

import SwiftUI

struct StudentFeaturedView : View {
    
    @Namespace var namespace
    @State var showStatusBar = true
    @State var selectedCat = ""
    @State var selectedId = UUID()
    @EnvironmentObject var model: ItemModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    var body: some View {
        ZStack {
            //Color("Background").ignoresSafeArea(.all)
            
            ScrollView {
                
                scrollDetection
                
                new
                
                Text("Categories".uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 10 ){
                    categories
                }.padding(.horizontal, 10)
                
            }
            .coordinateSpace(name: "scroll")
            .safeAreaInset(edge: .top, content: {
                Color.clear
                    .frame(height: 70)
            })
            .overlay(
                StudentNavBarView(title: "Home", pic: "square.grid.3x3", isHome: true, hasScrolled: $model.hasScrolled)
            )
            
            if model.showInd {
                individualItem
            }
            
            if model.showAll {
                StudentAllView().background(Color.white)
            }
            
        }
        .navigationBarHidden(true)
        .statusBar(hidden: !showStatusBar)
        .onChange(of: model.showInd) { newValue in
            withAnimation (.closeCard){
                if newValue == true {
                    showStatusBar = false
                } else {
                    showStatusBar = true
                }
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
                    model.hasScrolled = true
                } else {
                    model.hasScrolled = false
                }
            }
        })
    }
    
    var new: some View {
        TabView {
            ForEach(model.newItems) { item in
                GeometryReader { proxy in
                    let minX = proxy.frame(in: .global).minX
                    
                    NewItem(item: item)
                        .padding(.vertical, 10)
                    //.rotation3DEffect(.degrees(minX / -10), axis: (x: 0, y: 1, z: 0))
                        .shadow(radius: 5, x: 0, y: 5)
                        .blur(radius: abs(minX / 40))
                }.onTapGesture {
                    model.showInd.toggle()
                    model.showDetail.toggle()
                    showStatusBar = false
                    selectedId = item.id
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: UIScreen.main.bounds.height / 2.2)
        .background(
            Image("Background-2")
                .resizable()
                .ignoresSafeArea()
                .opacity(0.8)
                .mask(LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(20)
                .offset(y: -UIScreen.main.bounds.height / 4.5)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
        )
    }
    
    var individualItem: some View {
        ForEach(model.searchResults, id: \.self) { item in
            if item.id == selectedId {
                StudentItemView(item: item, show: $model.showInd)
                    .zIndex(1)
            }
        }
    }
    
    var categories: some View {
        ForEach(model.types, id: \.self) { type in
            ZStack {
                
                Image(type.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.5)
                //.offset(x: -10, y: 10)
                
                Text(type.category.uppercased())
                    .font(.footnote.weight(.semibold))
                    .foregroundColor(.secondary)
                    .padding(10)
                    
            }
            .onTapGesture {
                model.selectedCategory = type.category
                model.showAll.toggle()
            }
            .frame(width: UIScreen.main.bounds.width/3-15, height: UIScreen.main.bounds.width/3+20)
            .background(.ultraThinMaterial)
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            
        }
    }
    
    
    
}




struct NewItem : View {
    
    var item: Item
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        
        ZStack {
            
            if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 350, height: 325.0)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            }
            
        }
        .padding(.all, 20.0)
        .padding(.vertical, 20.0)
        .frame(width: 350, height: 350.0)
        .background(.clear)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle()
        .padding(.horizontal, 20.0)
        .overlay(
            VStack(alignment: .leading, spacing: 8.0) {
                Spacer()
                Spacer()
                VStack (alignment: .leading, spacing: 8.0){
                    Text(item.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text(item.type.uppercased())
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                    Text(item.description)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.padding(10)
                    .background(LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? [Color(red: 91/255, green: 107/255, blue: 116/255), Color(red: 91/255, green: 107/255, blue: 116/255).opacity(0.85)] : [Color.white, Color.white.opacity(0.85)]), startPoint: .bottom, endPoint: .top))
                    .cornerRadius(10)
                    .shadow(radius: 5)
            })
        
    }
    
    
    
}
