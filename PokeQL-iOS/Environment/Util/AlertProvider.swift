//
//  AlertProvider.swift
//  BeaconApp
//
//  Created by 山田隼也 on 2019/09/21.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

enum AlertProvider {

    static func alertWithOk(_ title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertController
    }
}
