//
//  Reusable+Helper.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit

public protocol Reusable: AnyObject {
    
    static var identifier: String { get }
}

public extension Reusable {
    
    static var identifier: String {
        return String(describing: self)
    }
}
