//
//  MainViewModel.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    
    // MARK: Dependency
    
    struct Dependency {
        let model: MainModel
    }
    private let dependency: Dependency
    
    // MARK: Properties
    
    private let disposeBag = DisposeBag()
    
    // - Input
    struct Input {
        
    }
    private let input: Input
    
    // - Output
    struct Output {
        let pokemonsDriver: Driver<[PokemonsQuery.Data.Pokemon]>
        let errorDriver: Driver<String>
    }
    let output: Output
    
    // MARK: Initializer
    
    init(dependency: Dependency, input: Input) {
        let pokemonsRelay: BehaviorRelay<[PokemonsQuery.Data.Pokemon]> = .init(value: [])
        let errorRelay: PublishRelay<String> = .init()
        
        self.dependency = dependency
        self.input = input
        self.output = Output(pokemonsDriver: pokemonsRelay.asDriver(),
                             errorDriver: errorRelay.asDriver(onErrorDriveWith: .empty()))
        
        dependency.model.fetchPokemons(30)
            .subscribe(onSuccess: { pokemons in
                pokemonsRelay.accept(pokemons)
            }, onError: { error in
                errorRelay.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
