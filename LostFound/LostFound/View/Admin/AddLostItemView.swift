//
//  AddLostItemView.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import SwiftUI



struct AddLostItemView: View {
    
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
                                .resizable()
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
                }.sheet(isPresented: $model.openCameraRoll) {
                    if model.useCamera {
                        ImagePicker(selectedImage: $model.imageSelected, sourceType: .camera)
                    } else {
                        ImagePicker(selectedImage: $model.imageSelected, sourceType: .photoLibrary)
                    }
                }
                
                Section (footer: Text("Please include information like brands, size, and names on item")) {
                    ZStack {
                        TextField("Item Lost", text: $model.enteredTitle)
                            .font(.headline)
                            .disabled(model.enteredTitle.count >= 20)

                        HStack {
                            Spacer()
                            Text("\(model.enteredTitle.count)/20")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    
                    Picker("Item Type", selection: $model.enteredType) {
                        ForEach(model.categories, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextEditor(text: $model.enteredDescription)
                }
                
            }
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        model.addItem(image: model.imageSelected, title: model.enteredTitle, isClaimed: 0, type: model.enteredType, description: model.enteredDescription)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            self.model.sortData(sortBy: model.enteredSort)
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }//.disabled(!model.changeProfileImage)
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
