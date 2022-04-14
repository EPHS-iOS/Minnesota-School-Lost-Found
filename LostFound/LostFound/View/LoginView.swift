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
                Spacer()
                
                Image("lightLogo")
                
                Text(" ")
                
                HStack {
                    
                    Spacer(minLength: 50)
                    
                    TextField("School Code", text: $schoolCode)
                        .textFieldStyle(.roundedBorder)
                        .cornerRadius(50)
                        .padding(.horizontal)
                        .font(.title3)
                    
                    Spacer(minLength: 50)
                    
                }

                
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
                Spacer()
            }.navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .background(Rectangle()
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? Color.white: Color.white, Color.blue]), startPoint: .bottom, endPoint: .top)))
                .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
}
