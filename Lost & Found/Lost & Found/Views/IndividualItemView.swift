//
//  IndividualItemView.swift
//  Lost & Found
//
//  Created by 90305906 on 3/15/22.
//

import SwiftUI

struct IndividualItemView: View {
    
    var item: Item
    
    var body: some View {
        Text(item.title)
    }
}
