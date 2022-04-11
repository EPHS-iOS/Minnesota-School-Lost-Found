//
//  EditLostItemView.swift
//  LostFound
//
//  Created by 90305906 on 4/9/22.
//

import SwiftUI



struct EditLostItemView: View {
    
    var item: Item
    
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
                                if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                                    Image(uiImage: image)
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
                                }
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
            
            }
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        itemModel.updateItem(item: item, image: aLIM.imageSelected, title: aLIM.enteredTitle, type: aLIM.enteredType, description: aLIM.enteredDescription)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .navigationTitle("Edit Item")
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            if let url = item.image, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                aLIM.imageSelected = image
            }
            aLIM.enteredTitle = item.title
            aLIM.enteredType = item.type
            aLIM.enteredDescription = item.description
        }
    }
}
