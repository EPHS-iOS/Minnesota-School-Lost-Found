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
                    .fill(Color("featColor"))
                    .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height - 300)
                    .cornerRadius(30)
                
                
                VStack {
                    
                    
                    Spacer(minLength: 200)
                    
                    
                    Image("lightLogo")
                    
                    
                    Text(" ")
                    
                    
                    VStack {
                        
                        
                        Spacer(minLength: 20)
                        HStack {
                            Spacer(minLength: 20)
                            TextField("District #", text: $schoolCode)
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
                                        .foregroundStyle(Color ("launchColor")))
                                    .cornerRadius(20)
                                
                                    .onTapGesture {
                                        for pass in model.passwords {
                                            var admin : Bool
                                            if pass.isAdmin == "yes" {
                                                admin = true
                                            } else {
                                                admin = false
                                            }
                                            if pass.password == schoolCode {
                                                model.school = pass.school
                                                if admin {
                                                    model.showAdmin = true
                                                    model.sortData(sortBy: model.enteredSort)
                                                } else {
                                                    model.showStudent = true
                                                    model.sortData(sortBy: model.enteredSort)
                                                    if model.items.count > 0 {
                                                        model.newLength = min(model.items.count, 5)
                                                        model.newItems = Array(model.items[0..<model.newLength])
                                                    } else {
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                                                            model.newLength = min(model.items.count, 5)
                                                            model.newItems = Array(model.items[0..<model.newLength])
                                                        }
                                                    }
                                                }
                                            }
                                        }
//                                        if schoolCode == "272mod" {
//                                            model.showAdmin = true
//                                        } else if schoolCode == "272" {
//                                            model.showStudent = true
//                                        }
                                        
                                        
                                    }
                                
                            }
                        }
                        
                      
                    }
                    Spacer(minLength: 200)
                    
                }
                
                
                
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .animation(Animation.easeOut(duration: 0.5))
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .background(Color("launchColor"))
        }
        .navigationBarBackButtonHidden(true)
        
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
