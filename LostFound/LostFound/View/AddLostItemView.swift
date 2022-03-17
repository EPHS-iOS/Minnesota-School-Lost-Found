//
//  AddLostItemView.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import SwiftUI

struct AddLostItemView: View {
    
    @EnvironmentObject var itemModel: ItemModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var useCamera = true
    @State var changeProfileImage = false
    @State var openCameraRoll = false
    @State var imageSelected = UIImage()
    
    @State private var enteredTitle : String = ""
    @State private var enteredDescription : String = ""
    @State private var enteredName : String = ""
    
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .bottomTrailing) {
                Button (action: {
                    changeProfileImage = true
                    openCameraRoll = true
                }, label: {
                    if changeProfileImage {
                        Image(uiImage: imageSelected)
                            .frame(width: 300, height: 300)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    } else {
                        Image(systemName: "photo")
                            .frame(width: 300, height: 300)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    }
                })//.sheet(isPresented: $openCameraRoll) {
                //   ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                // }
                ZStack {
                    Picker("Use Camera", selection: $useCamera, content: {
                        HStack {
                            Image(systemName: "camera")
                            Text("Camera")
                        }.tag(true)
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                            Text("Photo Library")
                        }.tag(false)
                    }).labelsHidden()
                    
//                    Image(systemName: "pencil")
//                        .frame(width: 30, height: 30)
//                        .foregroundColor(.white)
//                        .background(Color.gray)
//                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            }.sheet(isPresented: $openCameraRoll) {
                if useCamera {
                    ImagePicker(selectedImage: $imageSelected, sourceType: .camera)
                } else {
                    ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                }
            }
            
            Spacer()
            Text("Item lost")
            TextField("Item Lost", text: $enteredTitle)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("Does it have a name on it?")
            TextField("Name", text: $enteredName)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //Spacer()
            Text("Description")
            TextField("Description", text: $enteredDescription)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //Spacer()
            Button {
                itemModel.addItem(image: imageSelected, title: enteredTitle, addedDate: "03/16/2022", isClaimed: false, name: enteredName, description: enteredDescription)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add Item")
            }
            
        }
    }
}

struct AddLostItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddLostItemView()
    }
}
