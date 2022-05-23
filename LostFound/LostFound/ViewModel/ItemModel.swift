//
//  ItemModel.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import Foundation
import UIKit
import CloudKit
import SwiftUI

class ItemModel : ObservableObject {
    
    @Published var items = [Item]()
    @Published var searchText = ""
    @Published var selectedCategory = ""
    @Published var showingAddItem = false
    @Published var showingFilter = false
    @Published var showingEditItem = false
    @Published var newLength = 0
    @Published var newItems : [Item] = []
    
    @Published var enteredSort: String = "Date- New to Old"
    @Published var sortTypes: [String] = ["Date- New to Old", "Date- Old to New"]
    @Published var showTShirt = true
    @Published var showSweatshirt = true
    @Published var showShorts = true
    @Published var showPants = true
    @Published var showHat = true
    @Published var showWaterBottle = true
    @Published var showJewelry = true
    @Published var showOther = true
    
    @Published var isClaimed : Int64 = 0
    
    @Published var username: String = ""
    @Published var permissionStatus: Bool = false
    
    @Published var showDetail: Bool = false
    @Published var showInd = false
    @Published var hasScrolled = false
    @Published var showAll = false
    @Published var showSearch = false
    @Published var navHeight: CGFloat = 70
    
    @Published var useCamera = true
    @Published var changeProfileImage = false
    @Published var openCameraRoll = false
    @Published var imageSelected = UIImage()
    
    @Published var enteredTitle : String = "" {
        didSet {
            if enteredTitle.count > 20 && oldValue.count <= 20 {
                enteredTitle = oldValue
            }
        }
    }
    @Published var enteredDescription : String = ""
    @Published var enteredType : String = ""
    
    @Published var types: [type] = [
        type(category: "T-Shirt", image: "tshirt"),
        type(category: "Sweatshirt", image: "sweatshirt"),
        type(category: "Shorts", image: "shorts"),
        type(category: "Pants", image: "pants"),
        type(category: "Hat", image: "hat"),
        type(category: "Gloves/Mittens", image: "mitten"),
        type(category: "Water Bottle", image: "bottle"),
        type(category: "Jewelry", image: "jewelry"),
        type(category: "Shoes", image: "shoes"),
        type(category: "Electronics", image: "electronics"),
        type(category: "Other", image: "other")
        ]
    @Published var categories: [String] = ["T-Shirt", "Sweatshirt", "Shorts", "Pants", "Hat", "Gloves/Mittens", "Water Bottle", "Jewelry", "Shoes", "Electronics", "Other"]
    
    
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    var searchResults: [Item] {
        if selectedCategory.isEmpty {
            if searchText.isEmpty {
                return items
            } else {
                return items.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText) || $0.type.localizedCaseInsensitiveContains(searchText) }
            }
        } else {
            if searchText.isEmpty {
                return items.filter { $0.type.localizedCaseInsensitiveContains(selectedCategory) }
            } else {
                return items.filter {
                    ($0.type.localizedCaseInsensitiveContains(selectedCategory) && $0.title.localizedCaseInsensitiveContains(searchText))
                    || ($0.type.localizedCaseInsensitiveContains(selectedCategory) && $0.description.localizedCaseInsensitiveContains(searchText))
                    || ($0.type.localizedCaseInsensitiveContains(selectedCategory) && $0.type.localizedCaseInsensitiveContains(searchText))
                }
            }
        }
        
        
    }
    
    

    
    init() {
        requestPermission()
        sortData(sortBy: enteredSort)
        fetchRecordID()
        if items.count > 0 {
            newLength = min(items.count, 5)
            newItems = Array(items[0..<newLength])
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                self.newLength = min(self.items.count, 5)
                self.newItems = Array(self.items[0..<self.newLength])
            }
        }
        
    }
    
    
    func saveItem(record: CKRecord) {
        publicDB.save(record) { returnedRecord, returnedError in
            print(returnedRecord)
            print(returnedError)
            self.sortData(sortBy: self.enteredSort)
        }
    }
    
    
    func addItem(image: UIImage?, title: String, isClaimed: Int64, type: String, description: String) {
        let newItem = CKRecord(recordType: "LostItems")
        newItem["Title"] = title
        //newItem["Date Added"] = addedDate
        newItem["IsClaimed"] = isClaimed
        newItem["Type"] = type
        newItem["Description"] = description
        
        guard
            let image = image,
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("tempimage\(UUID().uuidString).jpg"),
            let data = image.jpegData(compressionQuality: 0.5) else { return }

        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            newItem["Image"] = asset
            saveItem(record: newItem)
        } catch let error {
            print(error)
        }
    }
    
    
    func fetchItems(sortBy: String, isAscending: Bool) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "LostItems", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: sortBy, ascending: isAscending)]
        
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems = [Item]()
        
        queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard
                    let imageAsset = record["Image"] as? CKAsset,
                    let title = record["Title"] as? String,
                    let isClaimed = record["IsClaimed"] as? Int64,
                    let type = record["Type"] as? String,
                    let description = record["Description"] as? String,
//                    let date = record["createdTimestamp"] as? Date,
                    let imageURL = imageAsset.fileURL
                else { return }
//                guard
//                    let numberOfDays = dateComponents([.day], from: date, to: Date.now),
//                    if numberOfDays.day! + 1 > 30 {
//
//                    }
//                else { return }
                returnedItems.append(Item(image: imageURL, title: title, isClaimed: isClaimed, type: type, description: description, record: record))
            case .failure(let error):
                print(error)
            }
        }
        
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.items = returnedItems
                self?.newLength = min((self?.items.count)!, 5)
                self?.newItems = Array((self?.items[0..<self!.newLength])!)
            }
            
        }
        addOperation(operation: queryOperation)
    }
    
    func addOperation(operation: CKDatabaseOperation) {
        publicDB.add(operation)
    }
    
    
    func updateItem(item: Item, image: UIImage?, title: String, type: String, description: String) {
        let record = item.record
        record["Title"] = title
        record["Type"] = type
        record["Description"] = description
        guard
            let image = image,
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("tempimage\(UUID().uuidString).jpg"),
            let data = image.jpegData(compressionQuality: 1.0) else { return }

        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            record["Image"] = asset
            saveItem(record: record)
        } catch let error {
            print(error)
        }
        
        sortData(sortBy: enteredSort)
    }
    
    func deleteItem(input: Item) {
        guard let item = items.first(where: {$0.id == input.id}) else { return }
        let index = items.firstIndex(of: item)
        let record = input.record
            
        publicDB.delete(withRecordID: record.recordID) { [weak self] returnedRecordID, returnedError in
            DispatchQueue.main.async {
                self?.items.remove(at: index!)
            }
        }
    }
    
    func claimItem(item: Item) {
        let record = item.record
        record["IsClaimed"] = -1
        saveItem(record: record)
    }
    
    func sortData(sortBy: String) {
        switch sortBy {
        case "Date- New to Old":
            fetchItems(sortBy: "creationDate", isAscending: false)
        case "Date- Old to New":
            fetchItems(sortBy: "creationDate", isAscending: true)
        default:
            print("sort type not found")
        }
    }
  
    func filterReset() {
        enteredSort = "Date- New to Old"
        showTShirt = true
        showSweatshirt = true
        showShorts = true
        showPants = true
        showHat = true
        showWaterBottle = true
        showJewelry = true
        showOther = true
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self.permissionStatus = true
                }
            }
        }
    }
    
    func fetchUserData(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedID, returnedError in
            DispatchQueue.main.async {
                if let firstName = returnedID?.nameComponents?.givenName, let lastName = returnedID?.nameComponents?.familyName {
                    self?.username = firstName + " " + lastName
                }
            }
        }
    }
    
    func fetchRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.fetchUserData(id: id)
            }
        }
    }
    
}
