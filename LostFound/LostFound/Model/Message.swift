//
//  Message.swift
//  LostFound
//
//  Created by 90305906 on 4/14/22.
//

import Foundation
import CloudKit


struct Message : Identifiable, Hashable {
    var id = UUID()
    var username : String
    var message : String
    var record : CKRecord
}
