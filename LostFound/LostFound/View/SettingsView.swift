//
//  SettingsView.swift
//  LostFound
//
//  Created by 90305906 on 4/11/22.
//

import SwiftUI


struct SettingsView: View {
    @State private var move = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                HStack {
                    Spacer()
                    //Text("Settings")
                    // .font(.title)
                    Spacer()
                    //log out button
                    
                        NavigationLink(destination: LoginView(), isActive: $move) {
                            Text("Logout").padding()
                                .foregroundColor(.white)
                                .background(Rectangle()
                                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .bottom, endPoint: .top)))
                                .cornerRadius(20)
                            
                                .onTapGesture {
                                        self.move = true
                                }
                            
                        }
                    
                    
//                    NavigationLink(destination: LoginView(), isActive: $move) {
//                        Text("Log Out").padding()
//                            .foregroundColor(.white)
//                            .background(Rectangle()
//                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .bottom, endPoint: .top)))
//                            .cornerRadius(20)
//
//                            .onTapGesture {
//                                self.move = true
//                            }
//
//
//                    }
                    Spacer()
                    
                }
                Spacer()
                VStack {
                    HStack {
                        Button("") {
                            print("red")
                        }.background(Color(.red))
                            .clipShape(Circle())
                    }
                    HStack {
                        
                    }
                }
                Spacer()
            }
        }//.navigationTitle("Settings")
        .navigationBarHidden(true)
        
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

