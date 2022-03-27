//
//  StudentIndividualItemView.swift
//  LostFound
//
//  Created by 90305906 on 3/26/22.
//

import SwiftUI

struct StudentIndividualItemView: View {
    var item: Item
    
    var body: some View {
        VStack {
            Text(item.title)
                .font(.title)
            Text(item.addedDate, format: .dateTime.day().month())
            Image(uiImage: item.image!)
                .resizable()
                .frame(height: 300)
            Spacer()
            
            Button {
                
                print("success")
            } label: {
                Text("Claim")
            }
            
            Spacer()
            
        }.navigationTitle(item.title)
            .navigationBarTitleDisplayMode(.automatic)
    }
}
