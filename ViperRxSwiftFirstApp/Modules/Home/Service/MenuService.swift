//
//  MenuService.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 15/02/2022.
//

import Foundation
import Moya

enum MenuService {
    case getMenu
    case getCategory
}

extension MenuService: TargetType {
    var baseURL: URL {
        return URL(string: "https://your-domain.com")!
    }
    
    var path: String {
        switch self {
        case .getMenu:
            return "/get"
        case .getCategory:
            return "/get"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMenu:
            return .get
        case .getCategory:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getMenu:
            let data = Utility.readLocalJSONFile(forName: "menus") ?? Data()
            return data
        case .getCategory:
            let category = ["Pizza","Sushi","Drinks"]
            guard let data = try? JSONSerialization.data(withJSONObject: category, options: []) else {
                return Data()
            }
            return data
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}

