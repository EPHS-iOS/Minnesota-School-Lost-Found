//
//  LoginView.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var schoolCode : String = ""
    
    var body: some View {
        
        Text("Minnesota Schools")
            .font(.largeTitle)
            .fontWeight(.bold)
          
        
        Image("MN")
     
        Text("Lost & Found")
            .font(.largeTitle)
        Text("Enter School Code")
            .font(.headline)
            .padding()
            
       
        TextField("School Code", text: $schoolCode)
            .padding(.horizontal)
        Spacer()
        Button("Enter") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
