//
//  LoginView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct LoginView: View {
    
    @State var schoolCode : String = ""
    @State private var response = ""
    @State private var adminMove = false
    @State private var studentMove = false

    
    var body: some View {
        NavigationView {
            VStack {
                Text("Minnesota Schools")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                Image("MN")
                
                Text("Lost & Found")
                    .font(.largeTitle)
                Text("Enter School Code")
                    .font(.headline)
                    .padding()
                Text(response)
                
                
                TextField("School Code", text: $schoolCode)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                NavigationLink(destination: AdminAllLostItemsView(), isActive: $adminMove) {
                    NavigationLink(destination: StudentAllLostItemsView(), isActive: $studentMove) {
                        Text("Enter")
                            .onTapGesture {
                                if schoolCode == "EPAdmin" {
                                    self.adminMove = true
                                } else if schoolCode == "EPStudent" {
                                    self.studentMove = true
                                }
                            }
                    }
                }
                
            }.navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
}
