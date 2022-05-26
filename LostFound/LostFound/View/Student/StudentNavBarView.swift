//
//  StudentNavBarView.swift
//  LostFound
//
//  Created by 90305906 on 5/18/22.
//

import SwiftUI

struct StudentNavBarView: View {
    
    var title = ""
    var pic = ""
    var isHome: Bool
    @State var move = false
    @Binding var hasScrolled: Bool
    @EnvironmentObject var model : ItemModel
    
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            
            
            
            VStack(spacing: 12) {
                
                HStack(spacing: 16) {
                    Text(title)
                        .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        //.padding(.top, 20)
                        .offset(y: hasScrolled ? -4 : 0)
                    
                    Spacer()
                    
                    
                    if isHome {
                        Button {
                            model.showStudent = false
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .environment(\.layoutDirection, .rightToLeft)
                                .font(.body.bold())
                                .frame(width: 36, height: 36)
                                .foregroundColor(.secondary)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .strokeStyle(cornerRadius: 14)
                            
                        }
                    } else {
                        Button {
                            model.showSearch.toggle()
                            if model.showSearch {
                                model.navHeight = 105
                            } else {
                                model.navHeight = 70
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(.body.bold())
                                .frame(width: 36, height: 36)
                                .foregroundColor(.secondary)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                                .strokeStyle(cornerRadius: 14)
                        }
                    }
                    
                    
                    Button {
                        model.selectedCategory = ""
                        model.searchText = ""
                        model.showSearch = false
                        model.navHeight = 70
                        model.showAll.toggle()
                        
                    } label: {
                        Image(systemName: pic)
                            .resizable()
                            .frame(width: 26, height: 26)
                            .foregroundColor(.secondary)
                            .padding(8)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .strokeStyle(cornerRadius: 18)
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)
                
                
                if model.showSearch && !hasScrolled {
                    searchBar
                        .padding(.bottom, 10)
                }
                
            }
            
        }
        //.padding(.top, 50)
        .frame(height: hasScrolled ? 44 : model.navHeight)
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
    
    var searchBar : some View {
        TextField("Search", text: $model.searchText)
            .padding(10)
            .padding(.leading, 5)
            .background(.ultraThinMaterial)
            .opacity(0.8)
            .cornerRadius(30)
            .frame(width: UIScreen.main.bounds.width-20)
            .overlay(
                HStack {
                    Spacer()
                    Button {
                        model.searchText = ""
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundColor(.secondary)
                            .padding(8)
                            .background(.ultraThinMaterial, in: Circle())
                            .padding(.trailing, 5)
                    }
                }
            )
    }
    
    
    
}

