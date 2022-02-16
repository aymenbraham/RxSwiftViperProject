//
//  Utility.swift
//  ViperRxSwiftFirstApp
//
//  Created by aymen braham on 15/02/2022.
//

import Foundation

class Utility: NSObject {

    static func readLocalJSONFile(forName name: String) -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("error: \(error)")
        }
        return nil
    }
}
