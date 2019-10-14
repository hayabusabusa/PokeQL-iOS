//
//  MainSection.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import Foundation

// MARK: - Section

enum MainSection {
    case grid
}

// MARK: - Item

struct MainItem: Hashable {
    let identifier: UUID = UUID()
    
    enum ItemType {
        case grid(model: PokemonsQuery.Data.Pokemon)
    }
    let itemType: ItemType
    
    static func == (lhs: MainItem, rhs: MainItem) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
