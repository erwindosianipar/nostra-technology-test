//
//  HomeViewModel.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import RxSwift

class HomeViewModel {
    
    var roles: [String] = []
    var temp: [HeroStatsResponseModel] = [] {
        didSet {
            switch UserDefaultConfig.heroFilter {
            case .default:
                self.temp = self.temp.sorted { $0.localized_name < $1.localized_name }
            case .baseAttack:
                self.temp = self.temp.sorted { $0.base_attack_min < $1.base_attack_min }
            case .baseHealt:
                self.temp = self.temp.sorted { $0.base_health < $1.base_health }
            case .baseMana:
                self.temp = self.temp.sorted { $0.base_mana < $1.base_mana }
            case .baseSpeed:
                self.temp = self.temp.sorted { $0.move_speed < $1.move_speed }
            }
        }
    }
    
    var heroes: [HeroStatsResponseModel] = [] {
        didSet {
            self.roles = []
            self.roles.append("All")
            for hero in heroes {
                self.roles += hero.roles
            }
            self.roles = Array(Set(self.roles)).sorted { $0 < $1 }
            self.temp = heroes
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
