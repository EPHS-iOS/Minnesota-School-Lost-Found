//
//  FilterModel.swift
//  LostFound
//
//  Created by 90305906 on 3/30/22.
//

import Foundation

class FilterModel : ObservableObject {
    @Published var filters = Filter()
    
    func reset() {
        filters.enteredSort = "Date- New to Old"
        filters.showTShirt = true
        filters.showSweatshirt = true
        filters.showShorts = true
        filters.showPants = true
        filters.showHat = true
        filters.showWaterBottle = true
        filters.showJewelry = true
        filters.showOther = true
    }
    
}
