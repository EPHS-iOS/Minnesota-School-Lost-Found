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
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Minnesota Schools")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? Color.white: Color.black, Color.red]), startPoint: .bottom, endPoint: .top))
                
                
                Image("EPLogo200x100")
                
                Text("Lost & Found")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? Color.white: Color.black, Color.red]), startPoint: .top, endPoint: .bottom))
                Text("Enter School Code")
                    .font(.headline)
                    .padding()
                Text(response)
                
                
                TextField("School Code", text: $schoolCode)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .border(LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? Color.white: Color.black, Color(red: 161/255, green: 32/255, blue: 22/255)]), startPoint: .bottom, endPoint: .top), width: 4)
                
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
