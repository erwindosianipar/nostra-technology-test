//
//  AppCoordinator.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit

internal final class AppCoordinator {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(window: window)
        homeCoordinator.start()
    }
}
