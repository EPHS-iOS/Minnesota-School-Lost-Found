//
//  EditLostItemView.swift
//  LostFound
//
//  Created by 90305906 on 4/9/22.
//

import SwiftUI



struct EditLostItemView: View {
    
    var item: Item
    
    @EnvironmentObject var model: ItemModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var currentScale: CGFloat = 0
    @State var finalScale: CGFloat = 1
    
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    
                    Menu {
                        Button {
                            model.useCamera = true
                            model.changeProfileImage = true
                            model.openCameraRoll = true
                        } label: {
                            Label {
                                Text("Camera")
                            } icon: {
                                Image(systemName: "camera")
                            }
                        }
                        Button {
                            model.useCamera = false
                            model.changeProfileImage = true
                            model.openCameraRoll = true
                        } label: {
                            Label {
                                Text("Photo Library")
                            } icon: {
                                Image(systemName: "photo.on.rectangle")
                            }
                        }
                    } label: {
                        if model.changeProfileImage {
                            Image(uiImage: model.imageSelected)
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
                }.sheet(isPresented: $model.openCameraRoll) {
                    if model.useCamera {
                        ImagePicker(selectedImage: $model.imageSelected, sourceType: .camera)
                    } else {
                        ImagePicker(selectedImage: $model.imageSelected, sourceType: .photoLibrary)
                    }
                }
                
                Section (footer: Text("Please include information like brands, size, and names on item")) {
                    
                    TextField("Item Lost", text: $model.enteredTitle)
                    Picker("Item Type", selection: $model.enteredType) {
                        ForEach(model.types, id: \.self) {
                            Text($0.category)
                        }
                    }
                    TextEditor(text: $model.enteredDescription)
                    
                }
            
            }
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        model.updateItem(item: item, image: model.imageSelected, title: model.enteredTitle, type: model.enteredType, description: model.enteredDescription)
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
                model.imageSelected = image
            }
            model.enteredTitle = item.title
            model.enteredType = item.type
            model.enteredDescription = item.description
        }
    }
}
