//
//  UINavigationController+Extension.swift
//  BeaconApp
//
//  Created by 山田隼也 on 2019/10/06.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

extension UINavigationController {

    func previousViewController() -> UIViewController? {
        let lenght = self.viewControllers.count
        return lenght >= 2 ? self.viewControllers[lenght - 2] : nil
    }
}
