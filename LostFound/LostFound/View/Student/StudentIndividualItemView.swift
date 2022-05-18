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
            //Text(item.title)
                //.font(.title)
            //Text(item.addedDate, format: .dateTime.day().month())
            Rectangle()
                .fill(Color.white)
                .frame(width: 350, height: 200)
                .cornerRadius(30)
                .foregroundColor(.red)
            HStack {
                Text("Expires in: ")
                Text("...date..")
                Text(" days")
            }
            if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 300)
            }
            
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
