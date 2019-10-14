//
//  MainViewModel.swift
//  PokeQL-iOS
//
//  Created by 山田隼也 on 2019/10/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import Foundation

final class MainViewModel: ViewModelType {
    
    struct Input {
        
    }
    let input: Input
    
    struct Output {
        
    }
    let output: Output
    
    init(input: Input) {
        self.input = input
        self.output = Output()
    }
}
