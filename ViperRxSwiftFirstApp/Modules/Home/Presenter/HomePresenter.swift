//
//  HomePresenter.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 14/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

typealias HomePresenterDependecies = (
    interactor: HomeInteractor,
    router: HomeRouter
)

protocol HomePresenterOutPut {
    var menuList: BehaviorRelay<[MenuModel]> { get }
    var cartList: BehaviorRelay<[MenuModel]> { get }
    var categoryList: BehaviorRelay<[String]> { get }
}

protocol HomePresenterInPut {
    func viewDidload()
    func addToCart()
    func goToCart(order: [MenuModel])
}

protocol HomePresenterProtocol {
    var inPuts: HomePresenterInPut { get }
    var outPuts: HomePresenterOutPut { get }
}

class HomePresenter: HomePresenterProtocol, HomePresenterInPut, HomePresenterOutPut {
    
    // MARK: Variables
    var inPuts: HomePresenterInPut { return self }
    var outPuts: HomePresenterOutPut { return self }
    var menuList = BehaviorRelay<[MenuModel]>(value: [])
    var cartList = BehaviorRelay<[MenuModel]>(value: [])
    var categoryList = BehaviorRelay<[String]>(value: [])
    var dependecies: HomePresenterDependecies?
    private let dispoeBag = DisposeBag()
    
    init(dependecies: HomePresenterDependecies) {
        self.dependecies = dependecies
    }
    
    func viewDidload() {
        
        let observerMenu = dependecies?.interactor.fetchMenus()
        observerMenu?.subscribe(onNext: { [weak self] array in
            guard let strongSelf = self else { return }
            strongSelf.menuList.accept(array)
        }).disposed(by: dispoeBag)
        
        let observerCategory = dependecies?.interactor.fetchCategories()
        observerCategory?.subscribe(onNext: { [weak self] array in
            guard let strongSelf = self else { return }
            strongSelf.categoryList.accept(array)
        }).disposed(by: dispoeBag)
        
        let observerCart = StoreManager.shared.cartList
        observerCart.observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] array in
                guard let strongSelf = self else { return }
                strongSelf.cartList.accept(array)
            }).disposed(by: dispoeBag)
    }
    
    // MARK: To Do
    func addToCart() {
        
    }
    
    func goToCart(order: [MenuModel]) {
        
    }
    

    
    
    
    
}
