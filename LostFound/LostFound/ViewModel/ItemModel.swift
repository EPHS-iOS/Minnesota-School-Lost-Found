//
//  ItemModel.swift
//  LostFound
//
//  Created by 90305906 on 3/16/22.
//

import Foundation
import UIKit
import CloudKit

class ItemModel : ObservableObject {
    
    @Published var items = [Item]()
    @Published var searchText = ""
    @Published var showingAddItem = false
    @Published var showingFilter = false
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    var searchResults: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText) || $0.type.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init() {
        fetchItems()
    }
    
    
    func saveItem(record: CKRecord) {
        publicDB.save(record) { [weak self] returnedRecord, returnedError in
            print(returnedRecord)
            print(returnedError)
            DispatchQueue.main.async {
                self?.fetchItems()
            }
        }
    }
    
    
    func addItem(image: UIImage?, title: String, isClaimed: Int64, type: String, description: String) {
        let newItem = CKRecord(recordType: "LostItems")
        newItem["Title"] = title
        //newItem["Date Added"] = addedDate
        newItem["IsClaimed"] = isClaimed
        newItem["Type"] = type
        newItem["Description"] = description
//        if tags.count != 0 {
//            newItem["Tags"] = tags
//        }
        
        guard
            let image = image,
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("tempimage\(UUID().uuidString).jpg"),
            let data = image.jpegData(compressionQuality: 1.0) else { return }

        do {
            try data.write(to: url)
            let asset = CKAsset(fileURL: url)
            newItem["Image"] = asset
            saveItem(record: newItem)
        } catch let error {
            print(error)
        }
        
        //items.append(Item(image: image, title: title, isClaimed: isClaimed, type: type, description: description, tags: tags))
    }
    
    
    func fetchItems() {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "LostItems", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
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
                    //let tags = record["Tags"] as? [String],
                    let imageURL = imageAsset.fileURL
                else { return }
                returnedItems.append(Item(image: imageURL, title: title, isClaimed: isClaimed, type: type, description: description, record: record))
            case .failure(let error):
                print(error)
            }
        }
        
        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                self?.items = returnedItems
            }
            
        }
        addOperation(operation: queryOperation)
    }
    
    
    func addOperation(operation: CKDatabaseOperation) {
        publicDB.add(operation)
    }
    
    
    func updateItem(item: Item) {
        let record = item.record
        record["Title"] = "Editted Title"
        saveItem(record: record)
    }
    
    
    func claimItem(id: UUID) {
        if let item = items.first(where: {$0.id == id}) {
            let index = items.firstIndex(of: item)
            
            items[index!].isClaimed = 1
        }
    }
    
    func editItem(id: UUID, image: URL?, title: String, isClaimed: Int64, description: String) {
        if let item = items.first(where: {$0.id == id}) {
            let index = items.firstIndex(of: item)
            
            items[index!].image = image
            items[index!].title = title
            items[index!].isClaimed = isClaimed
            items[index!].description = description
        }
    }
    
    func deleteItem(id: UUID) {
        if let item = items.first(where: {$0.id == id}) {
            let index = items.firstIndex(of: item)
            
            items.remove(at: index!)
        }
    }
    
}
