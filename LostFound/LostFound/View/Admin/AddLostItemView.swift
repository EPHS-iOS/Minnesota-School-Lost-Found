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
    @StateObject var aLIM = AddLostItemModel()
    
    @State var currentScale: CGFloat = 0
    @State var finalScale: CGFloat = 1
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    
                    Menu {
                        Button {
                            aLIM.useCamera = true
                            aLIM.changeProfileImage = true
                            aLIM.openCameraRoll = true
                        } label: {
                            Label {
                                Text("Camera")
                            } icon: {
                                Image(systemName: "camera")
                            }
                        }
                        Button {
                            aLIM.useCamera = false
                            aLIM.changeProfileImage = true
                            aLIM.openCameraRoll = true
                        } label: {
                            Label {
                                Text("Photo Library")
                            } icon: {
                                Image(systemName: "photo.on.rectangle")
                            }
                        }
                    } label: {
                        if aLIM.changeProfileImage {
                            Image(uiImage: aLIM.imageSelected)
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
                                    //for zooming in/out, not done but this is a start
                                    .scaleEffect(finalScale + currentScale)
                                    .gesture(MagnificationGesture()
                                                .onChanged {
                                        newScale in currentScale = newScale
                                    }
                                                .onEnded {
                                        scale in finalScale = scale
                                        currentScale = 0
                                    }
                                    )
                                Spacer()
                            }
                        }
                    }
                }.sheet(isPresented: $aLIM.openCameraRoll) {
                    if aLIM.useCamera {
                        ImagePicker(selectedImage: $aLIM.imageSelected, sourceType: .camera)
                    } else {
                        ImagePicker(selectedImage: $aLIM.imageSelected, sourceType: .photoLibrary)
                    }
                }
                
                Section (footer: Text("Please include information like brands, size, and names on item")) {
                    TextField("Item Lost", text: $aLIM.enteredTitle)
                    Picker("Item Type", selection: $aLIM.enteredType) {
                        ForEach(aLIM.types, id: \.self) {
                        Text($0)
                    }
                }
                    TextEditor(text: $aLIM.enteredDescription)
                }
                
                Section {
                    HStack {
                        TextField("Tags", text: $aLIM.enteredTag).textInputAutocapitalization(.never)
                        Button {
                            aLIM.tagArray.append(aLIM.enteredTag)
                            aLIM.enteredTag = ""
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                    
                    HStack {
                        ForEach(aLIM.tagArray, id: \.self) { tag in
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
                        itemModel.addItem(image: aLIM.imageSelected, title: aLIM.enteredTitle, addedDate: Date.now, isClaimed: false, type: aLIM.enteredType, description: aLIM.enteredDescription, tags: aLIM.tagArray)
                        //itemModel.testAddItem(title: aLIM.enteredTitle)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }.disabled(!aLIM.changeProfileImage)
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
