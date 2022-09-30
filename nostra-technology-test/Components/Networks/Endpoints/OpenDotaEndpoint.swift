//
//  OpenDotaEndpoint.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

enum OpenDotaEndpoint {
    case heroStats
}

extension OpenDotaEndpoint: Endpoint {
    var base: String {
        return "https://api.opendota.com/api"
    }
    
    var method: String {
        switch self {
        case .heroStats:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .heroStats:
            return "/herostats"
        }
    }
}
