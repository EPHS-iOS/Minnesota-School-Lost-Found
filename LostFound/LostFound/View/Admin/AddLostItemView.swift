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
                        itemModel.addItem(image: aLIM.imageSelected, title: aLIM.enteredTitle, isClaimed: 0, type: aLIM.enteredType, description: aLIM.enteredDescription)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            self.itemModel.sortData(sortBy: itemModel.enteredSort)
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }//.disabled(!aLIM.changeProfileImage)
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
