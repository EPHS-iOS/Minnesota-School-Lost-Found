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
        
        NavigationView {
            Form {
                Section {
                    Button (action: {
                        changeProfileImage = true
                        openCameraRoll = true
                    }, label: {
                        if changeProfileImage {
                            Image(uiImage: imageSelected)
                                .frame(width: 300, height: 300)
                                .foregroundColor(.white)
                                .background(Color.gray)
                            
                        } else {
                            Image(systemName: "photo")
                                .frame(width: 300, height: 300)
                                .foregroundColor(.white)
                                .background(Color.gray)
                            
                        }
                    })
                    //                    ZStack {
                    //                        Picker("Use Camera", selection: $useCamera, content: {
                    //                            HStack {
                    //                                Image(systemName: "camera")
                    //                                Text("Camera")
                    //                            }.tag(true)
                    //                            HStack {
                    //                                Image(systemName: "photo.on.rectangle")
                    //                                Text("Photo Library")
                    //                            }.tag(false)
                    //                        }).labelsHidden()
                    //                    }
                }.sheet(isPresented: $openCameraRoll) {
                    //                    if useCamera {
                    //                        ImagePicker(selectedImage: $imageSelected, sourceType: .camera)
                    //                    } else {
                    ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                    //}
                }
                
                TextField("Item Lost", text: $enteredTitle)
                TextField("Description", text: $enteredDescription)
                
            }
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        itemModel.addItem(image: imageSelected, title: enteredTitle, addedDate: Date.now, isClaimed: false, description: enteredDescription)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
            
        }
    }
}

struct AddLostItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddLostItemView()
    }
}
