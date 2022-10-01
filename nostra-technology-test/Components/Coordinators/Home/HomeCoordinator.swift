//
//  HomeCoordinator.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import UIKit

internal final class HomeCoordinator: NavigationCoordinator {
    
    let window: UIWindow
    
    var navigationController: UINavigationController = UINavigationController()
    
    var screenStack: [Screenable] = []
    
    var onCompleted: ((ScreenResult?) -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let screens = [
            HomeScreen(())
        ]
        
        set(screens)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showScreen(identifier: String, navigation: Navigation) {
        switch identifier {
        case kHomeScreen:
            switch navigation {
            case .next(let value):
                if let result = value as? HeroStatsResponseModel {
                    push(DetailScreen((result)))
                }
            case .prev:
                return
            }
        default:
            return
        }
    }
}
