//
//  Res.swift
//  CodableExample
//
//  Created by Condy on 2024/6/10.
//

import Foundation

struct Res {
    
    /// Read json data
    public static func jsonData(_ named: String) -> Data? {
        guard let path = ["json", "JSON", "Json"].compactMap({
            Bundle.main.path(forResource: named, ofType: $0)
        }).first else {
            return nil
        }
        let contentURL = URL(fileURLWithPath: path)
        return try? Data(contentsOf: contentURL)
    }
}
