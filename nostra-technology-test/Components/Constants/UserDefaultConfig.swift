//
//  UserDefaultConfig.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import Foundation

@propertyWrapper
struct UserDefault<T: Codable> {
    
    let key: String
    let value: T
    
    init(key: String, value: T) {
        self.key = key
        self.value = value
    }
    
    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
               let object = try? JSONDecoder().decode(T.self, from: data) {
                return object
            }
            
            return value
        }
        
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}

internal struct UserDefaultConfig {
    
    @UserDefault(key: "heroFilter", value: HeroFilter.default)
    static var heroFilter: HeroFilter
}
