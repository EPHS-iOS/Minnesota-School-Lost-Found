//
//  Filter.swift
//  LostFound
//
//  Created by 90305906 on 3/30/22.
//

import Foundation

class Filter : ObservableObject {
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
}