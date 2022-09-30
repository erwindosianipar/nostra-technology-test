//
//  BaseEndpoint.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

protocol Endpoint {
    var base: String { get }
    var method: String { get }
    var path: String { get }
}
