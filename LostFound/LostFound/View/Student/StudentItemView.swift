//
//  StudentIndividualItemView.swift
//  LostFound
//
//  Created by 90305906 on 5/18/22.
//

import SwiftUI

struct StudentItemView: View {
    
    var item: Item
    @EnvironmentObject var model : ItemModel
    @Binding var show: Bool
    
    
    var body: some View {
       
            ZStack {
                
                Color(.white)
                    .ignoresSafeArea()
                
                Image("Background")
                
                    .resizable()
                    .ignoresSafeArea()
                    .mask(LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(20)
                    .offset(y: -UIScreen.main.bounds.height / 4.5)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
                
                
                
                ScrollView {
                    
                    scrollDetection
                    
                    if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 80)
                            .border((LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .bottom, endPoint: .top)), width: 10)
                            .cornerRadius(25)
                            .padding([.leading, .trailing, .bottom], 20)
                            .shadow(radius: 5)
                    }
                    
                    description
                    
                    Spacer(minLength: 30)
                    
                    Button {
                        model.claimItem(item: item)
                    } label: {
                        if item.isClaimed == 0 {
                            Text("Claim Item")
                        } else {
                            Text("Claimed")
                        }
                        
                    }.frame(width: 250, height: 25)
                        .padding()
                        .foregroundColor(.white)
                        .background((LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .bottom, endPoint: .top)))
                        .cornerRadius(20)
                        .disabled(item.isClaimed != 0)
                    
                    
                }.coordinateSpace(name: "scroll")
                    .safeAreaInset(edge: .top, content: {
                        Color.clear
                            .frame(height: 70)
                    })
                    .overlay(
                        NavBarItemView(title: item.title, hasScrolled: $model.hasScrolled, show: $model.showInd)
                    )
                
            }
    }
    
    var description: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Description")
                .font(.title.weight(.bold))
            
            Text(item.description)
            
            Divider()
                .opacity(0.8)
            
            HStack {
                Text("Category: \(item.type)")
                    .font(.footnote)
                    .opacity(0.6)
            }
            
        }
        .padding([.top, .leading, .trailing], 20)
        .padding(.bottom, 30)
        .frame(width: UIScreen.main.bounds.width-30, alignment: .leading)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .opacity(0.8)
                .shadow(radius: 5)
        )
        
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
    
}
