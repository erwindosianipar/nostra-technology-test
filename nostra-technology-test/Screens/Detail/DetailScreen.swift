//
//  DetailScreen.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

let kDetailScreen = "Detail Screen"

internal final class DetailScreen: Screen<HeroStatsResponseModel> {
    
    override var identifier: String {
        return kDetailScreen
    }
    
    override func build() -> ViewController {
        let viewModel = DetailViewModel(screenResult: input)
        let viewController = DetailViewController(viewModel: viewModel)
        
        viewController.navigationEvent.on({ navigation in
            self.event?(navigation)
        })
        
        return viewController
    }
}
