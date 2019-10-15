//
//  MainModel.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift

protocol MainModel {
    func fetchPokemons(_ count: Int) -> Single<[PokemonsQuery.Data.Pokemon]>
}

struct MainModelImpl: MainModel {
    
    // MARK: Dependency
    
    struct Dependency {
        let pokeQLProvider: PokeQLProvider
    }
    private let dependency: Dependency
    
    // MARK: Initializer
    
    init(dependency: Dependency = Dependency(pokeQLProvider: PokeQLProvider.shared)) {
        self.dependency = dependency
    }
    
    // MARK: Network
    
    func fetchPokemons(_ count: Int) -> Single<[PokemonsQuery.Data.Pokemon]> {
        return Single.create { observer in
            self.dependency.pokeQLProvider.apolloClient.fetch(query: PokemonsQuery(count: count)) { result in
                switch result {
                case .success(let response):
                    if let error = response.errors?.first {
                        observer(.error(error))
                    }
                    if let pokemons = response.data?.pokemons {
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
