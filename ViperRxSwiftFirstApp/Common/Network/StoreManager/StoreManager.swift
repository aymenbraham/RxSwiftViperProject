//
//  StoreManager.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 15/02/2022.
//

import Foundation
import RxCocoa

protocol CartInterface {
    func addToCart(index: Int)
    func deleteFromCart(index: Int)
}

class StoreManager: CartInterface{
    
    // MARK: - Properties
    static let shared = StoreManager()
    
    // MARK: -
    var cartList = BehaviorRelay<[MenuModel]>(value: [])
    
    func addToCart(index: Int) {
        let value = self.cartList.value
        self.cartList.accept(value)
    }
    
    func deleteFromCart(index: Int) {
        var value = self.cartList.value
        value.remove(at: index)
        self.cartList.accept(value)
    }
}
