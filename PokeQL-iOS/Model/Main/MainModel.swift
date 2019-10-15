//
//  MainModel.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol MainModel {
    func fetchPokemons() -> Single<[PokemonsQuery.Data.Pokemon]>
}

struct MainModelImpl: MainModel {
    
    // MARK: Dependency
    
    struct Dependency {
        let pokeQLProvider: PokeQLProvider
    }
    private let dependency: Dependency
    
    // MARK: Properties
    
    private let countRelay: BehaviorRelay<Int> = .init(value: 30)
    
    // MARK: Initializer
    
    init(dependency: Dependency = Dependency(pokeQLProvider: PokeQLProvider.shared)) {
        self.dependency = dependency
    }
    
    // MARK: Network
    
    func fetchPokemons() -> Single<[PokemonsQuery.Data.Pokemon]> {
        return Single.create { observer in
            var count = self.countRelay.value
            if 150 <= count {
                observer(.error(NSError(domain: "Limit", code: -999, userInfo: nil)))
            }
            
            self.dependency.pokeQLProvider.apolloClient.fetch(query: PokemonsQuery(count: count)) { result in
                switch result {
                case .success(let response):
                    if let error = response.errors?.first {
                        observer(.error(error))
                    }
                    if let pokemons = response.data?.pokemons {
                        self.countRelay.accept(count + 10)
                        observer(.success(pokemons.compactMap { $0 }))
                    }
                    // Empty?
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
