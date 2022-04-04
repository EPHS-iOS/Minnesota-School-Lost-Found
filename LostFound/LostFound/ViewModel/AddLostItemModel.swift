//
//  AddLostItemModel.swift
//  LostFound
//
//  Created by 90305906 on 4/3/22.
//

import Foundation
import UIKit

class AddLostItemModel: ObservableObject {
    
    @Published var useCamera = true
    @Published var changeProfileImage = false
    @Published var openCameraRoll = false
    @Published var imageSelected = UIImage()
    
    @Published var enteredTitle : String = ""
    @Published var enteredDescription : String = ""
    @Published var enteredType : String = ""
    @Published var enteredTag : String = ""
    @Published var tagArray : [String] = []
    
    @Published var types = ["t-shirt", "sweatshirt", "shorts", "pants", "hat", "water bottle", "jewelry", "other"]
    
}
