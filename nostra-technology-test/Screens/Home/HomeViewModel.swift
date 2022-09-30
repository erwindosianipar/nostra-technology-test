//
//  HomeViewModel.swift
//  nostra-technology-test
//
//  Created by Erwindo Sianipar on 30/09/22.
//

import RxSwift

internal final class HomeViewModel {
    
    func heroStats() -> Observable<HeroStatsResponseModel> {
        return Observable.create { observer in
            let endpoint = OpenDotaEndpoint.heroStats
            APIProvider.dataRequest(endpoint: endpoint, body: [:], response: HeroStatsResponseModel.self) { result in
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
