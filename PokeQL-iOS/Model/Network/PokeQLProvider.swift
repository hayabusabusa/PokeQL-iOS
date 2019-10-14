//
//  PokeQLProvider.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import Foundation
import Apollo

final class PokeQLProvider {
    
    // MARK: Singletone
    
    static let shared: PokeQLProvider = .init()
    
    // MARK: Properties
    
    private let endpoint: String = "https://graphql-pokemon.now.sh"
    public let apolloClient: ApolloClient
    
    // MARK: Initializer
    
    private init () {
        apolloClient = ApolloClient(url: URL(string: endpoint)!)
    }
    
    // MARK: Functions
}
