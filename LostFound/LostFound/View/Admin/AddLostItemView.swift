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
    @StateObject var aLIM = AddLostItemModel()
    
    @State var currentScale: CGFloat = 0
    @State var finalScale: CGFloat = 1
    let color: UIColor = UIColor(red: 29/255.0,green: 161/255.0,blue: 242/25.0,alpha: 1)
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(color))]
    }
    
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
                                .background(Color.white)
                        } else {
                            HStack {
                                Spacer()
                                Image("Camera")
                                    .frame(width: 300, height: 300)
                                    .foregroundColor(.white)
                                    .background(Color.white)
                                    .cornerRadius(150)
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
                
                Section (footer: Text("Please include information like brands, size, and names on item").foregroundColor(.white))
                {
                    TextField("Item Lost", text: $aLIM.enteredTitle)
                    Picker("Item Type", selection: $aLIM.enteredType) {
                        ForEach(aLIM.types, id: \.self) {
                        Text($0)
                    }
                }
                    TextEditor(text: $aLIM.enteredDescription)
                }
                
            }
            .onAppear {
               UITableView.appearance().backgroundColor = color
            }
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        model.addItem(image: aLIM.imageSelected, title: aLIM.enteredTitle, isClaimed: 0, type: aLIM.enteredType, description: aLIM.enteredDescription)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            self.model.sortData(sortBy: model.enteredSort)
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
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
