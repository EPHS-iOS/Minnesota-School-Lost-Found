//
//  Animation.swift
//  LostFound
//
//  Created by 64008786 on 4/27/22.
//

import SwiftUI


class globalVariable: ObservableObject{
    @Published var loginViewChange: Bool = false
}


struct AnimationStart: View {
    let color: UIColor = UIColor(red: 29/255.0,green: 161/255.0,blue: 242/25.0,alpha: 1)
    @State var animate: Bool = false
    @State var animatesec: Bool = false
    
    
    
    @EnvironmentObject var globalVar: globalVariable

    
    var body: some View {
        ZStack {
            
            Color(color)
            
            Image("darkLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 198, height: 262)
                .scaleEffect(animate ? 1000 : 1)
                .animation(Animation.easeIn(duration: 1))
                
            
        }
        
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                animate.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                globalVar.loginViewChange.toggle()
                
            }
            

        }
    }
}

struct AnimationStart_Previews: PreviewProvider {
    static var previews: some View {
        AnimationStart()
    }
}
