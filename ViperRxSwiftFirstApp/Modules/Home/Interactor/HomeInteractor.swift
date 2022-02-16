//
//  HomeInteractor.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 14/02/2022.
//

import Foundation
import Moya
import RxSwift

protocol HomeInteractorProtocol {
    func fetchCategories() -> Observable<[String]>
    func fetchMenus() -> Observable<[MenuModel]>
}

class HomeInteractor: HomeInteractorProtocol {
    
    private var provider: MoyaProvider<MenuService>
    
    init(provider: MoyaProvider<MenuService> = MoyaProvider<MenuService>()) {
        self.provider = provider
    }
    
    func fetchCategories() -> Observable<[String]> {
        let observer = Observable<[String]>.create { (observe) -> Disposable in
            self.provider.request(.getCategory) { result in
                switch result {
                case let .success(response):
                    do {
                        let value = try response.map([String].self)
                        observe.on(.next(value))
                        return
                    } catch {
                        observe.on(.error(NSError(domain: "Network Error", code: 0, userInfo: nil)))
                        return
                    }
                case .failure(_):
                    observe.on(.error(NSError(domain: "Network Error", code: 0, userInfo: nil)))
                    return
                }
            }
            return Disposables.create()
        }
        return observer
    }
    
    func fetchMenus() -> Observable<[MenuModel]> {
        let observer = Observable<[MenuModel]>.create { (observer) -> Disposable in
            self.provider.request(.getMenu) { result in
                switch result {
                case let .success(response):
                    do {
                        let value = try response.map([MenuModel].self)
                        observer.on(.next(value))
                        return
                    } catch {
                        observer.on(.error(NSError(domain: "Network Error", code: 0, userInfo: nil)))
                        return
                    }
                case .failure(_):
                    observer.on(.error(NSError(domain: "Network Error", code: 0, userInfo: nil)))
                    return
                    
                }
            }
            return Disposables.create()
        }
        return observer
    }
    
}
