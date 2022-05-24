//
//  LoginView.swift
//  LostFound
//
//  Created by 64008786 on 3/16/22.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var model = ItemModel()
    @State var schoolCode : String = ""
    @State private var response = ""
    @State private var adminMove = false
    @State private var studentMove = false
    let color: UIColor = UIColor(red: 29/255.0,green: 161/255.0,blue: 242/25.0,alpha: 1)
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
                
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 350, height: 500)
                    .cornerRadius(30)
                
                
                VStack {
                    
                    
                    Spacer(minLength: 200)
                    
                    
                    Image("lightLogo")
                    
                    
                    Text(" ")
                    
                    
                    VStack {
                        
                        
                        Spacer(minLength: 20)
                        HStack {
                            Spacer(minLength: 20)
                            TextField("School Code", text: $schoolCode)
                                .textFieldStyle(.roundedBorder)
                                .cornerRadius(50)
                                .padding(.horizontal)
                                .font(.title3)
                            Spacer(minLength: 20)
                        }
                        
                        
                        Spacer(minLength: 10)
                        
                        NavigationLink(destination: AdminAllView().environmentObject(model), isActive: $model.showAdmin) {
                            NavigationLink(destination: StudentFeaturedView().environmentObject(model), isActive: $model.showStudent) {
                                Text("Enter").padding()
                                    .foregroundColor(.white)
                                    .background(Rectangle()
                                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .bottom, endPoint: .top)))
                                    .cornerRadius(20)
                                
                                    .onTapGesture {
                                        if schoolCode == "123456789" {
                                            model.showAdmin = true
                                        } else if schoolCode == "272" {
                                            model.showStudent = true
                                        }
                                        
                                        
                                    }
                                
                            }
                        }
                        
                        //                        Button {
                        //                            if schoolCode == "admin" {
                        //                                model.showAdmin = true
                        //                            } else if schoolCode == "272" {
                        //                                model.showStudent = true
                        //                            }
                        //                        } label: {
                        //                            Text("Enter")
                        //                                .padding()
                        //                                .foregroundColor(.white)
                        //                                .background(Rectangle()
                        //                                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.blue]), startPoint: .bottom, endPoint: .top)))
                        //                                .cornerRadius(20)
                        //                        }
                    }
                    Spacer(minLength: 200)
                    
                }
                
                //                if model.showStudent {
                //                    StudentFeaturedView().environmentObject(model)
                //                        .ignoresSafeArea()
                //
                //                } else if model.showAdmin {
                //                    AdminAllView().environmentObject(model)
                //                }
                
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .animation(Animation.easeOut(duration: 0.5))
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .background(Color (red: 29/255.0,green: 161/255.0,blue: 242/25.0))
        }
        .navigationBarBackButtonHidden(true)
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
