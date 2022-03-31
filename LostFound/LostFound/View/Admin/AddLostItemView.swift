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
                    Button (action: {
                      
                        changeProfileImage = true
                        openCameraRoll = true
                    }, label: {
                        if changeProfileImage {
                            Image(uiImage: imageSelected)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                                .frame(width: 300, height: 300)
                                .background(Color.gray)
                                
                      /*
                                .alignmentGuide(<#T##g: HorizontalAlignment##HorizontalAlignment#>, computeValue: <#T##(ViewDimensions) -> CGFloat#>)
                       */
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
                
                Section (footer: Text("Please include info like names or brands")) {
                TextField("Item Lost", text: $enteredTitle)
                Picker("Item Type", selection: $enteredType) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }//.pickerStyle(.wheel)
                    .foregroundColor(.gray)
                TextEditor(text: $enteredDescription)
                }
                
                Section {
                    HStack {
                        TextField("Tags", text: $enteredTag)
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
                                    Image(systemName: "x.circle")
                                }
                            }
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        itemModel.addItem(image: imageSelected, title: enteredTitle, addedDate: Date.now, isClaimed: false, description: enteredDescription, tags: tagArray)
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
