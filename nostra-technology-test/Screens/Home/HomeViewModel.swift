//
//  HomeViewModel.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import RxSwift

internal final class HomeViewModel {
    
    var roles: [String] = []
    var temp: [HeroStatsResponseModel] = []
    var heroes: [HeroStatsResponseModel] = [] {
        didSet {
            self.roles = []
            self.roles.append("All")
            for hero in heroes {
                self.roles += hero.roles
            }
            self.roles = Array(Set(self.roles)).sorted { $0 < $1 }
            self.temp = heroes.sorted { $0.localized_name < $1.localized_name }
        }
    }
    
    func heroStats() -> Observable<[HeroStatsResponseModel]> {
        return Observable.create { observer in
            APIProvider.dataRequest(endpoint: OpenDotaEndpoint.heroStats, body: [:], response: [HeroStatsResponseModel].self) { result in
                switch result {
                case .success(let result):
                    observer.onNext(result)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
