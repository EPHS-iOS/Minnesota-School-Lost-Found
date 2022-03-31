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
    @State var imagePicked = false
    
    @State private var enteredTitle : String = ""
    @State private var enteredDescription : String = ""
    @State private var enteredName : String = ""
    @State private var enteredType : String = ""
    @State private var enteredTag : String = ""
    @State private var tagArray : [String] = []
    
    private var types = ["t-shirt", "sweatshirt", "shorts", "pants", "hat", "water bottle", "jewelry", "other"]
    
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    
                    Menu {
                        Button {
                            useCamera = true
                            changeProfileImage = true
                            openCameraRoll = true
                        } label: {
                            Label {
                                Text("Camera")
                            } icon: {
                                Image(systemName: "camera")
                            }
                        }
                        Button {
                            useCamera = false
                            changeProfileImage = true
                            openCameraRoll = true
                        } label: {
                            Label {
                                Text("Photo Library")
                            } icon: {
                                Image(systemName: "photo.on.rectangle")
                            }
                        }
                    } label: {
                        if changeProfileImage {
                            Image(uiImage: imageSelected)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                                .frame(width: 300, height: 300)
                                .background(Color.gray)
                        } else {
                            HStack {
                                Spacer()
                                Image(systemName: "photo")
                                    .frame(width: 300, height: 300)
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                Spacer()
                            }
                        }
                    }
                }.sheet(isPresented: $openCameraRoll) {
                    if useCamera {
                        ImagePicker(selectedImage: $imageSelected, sourceType: .camera)
                    } else {
                        ImagePicker(selectedImage: $imageSelected, sourceType: .photoLibrary)
                    }
                }
                
                Section (footer: Text("Please include info like names or brands")) {
                TextField("Item Lost", text: $enteredTitle)
                Picker("Item Type", selection: $enteredType) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextEditor(text: $enteredDescription)
                }
                
                Section {
                    HStack {
                        TextField("Tags", text: $enteredTag).textInputAutocapitalization(.never)
                        Button {
                            tagArray.append(enteredTag)
                            enteredTag = ""
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    
                    HStack {
                        ForEach(tagArray, id: \.self) { tag in
                            Button {
                            
                            } label: {
                                HStack {
                                    Text(tag)
                                        .padding(.horizontal)
                                    Image(systemName: "x.circle")
                                }
                            }//.padding(.leading)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .cornerRadius(.infinity)
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        itemModel.addItem(image: imageSelected, title: enteredTitle, addedDate: Date.now, isClaimed: false, type: enteredType, description: enteredDescription, tags: tagArray)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .font(.title3)
                    }.disabled(!changeProfileImage)
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddLostItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddLostItemView()
    }
}
