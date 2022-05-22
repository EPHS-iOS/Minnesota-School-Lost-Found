//
//  NavBarItemView.swift
//  LostFound
//
//  Created by 90305906 on 5/18/22.
//

import SwiftUI

struct NavBarItemView: View {
    var title = ""
    @Binding var hasScrolled: Bool
    @EnvironmentObject var model : ItemModel
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            
            Text(title)
                .animatableFont(size: hasScrolled ? 22 : 30, weight: .bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)
            
            HStack(spacing: 16) {
                
                Button  {
                    model.selectedCategory = ""
                    withAnimation (.closeCard){
                        show.toggle()
                        model.showDetail.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.body.weight(.bold))
                        .foregroundColor(.secondary)
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(20)
                //.ignoresSafeArea()
                
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)
            
        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
        
    }
}

