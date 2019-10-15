//
//  BaseNavigationController.swift
//  Holder
//
//  Created by Yamada Shunya on 2019/09/10.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit
import SwifterSwift

class BaseNavigationController: UINavigationController {

    // MARK: - Overrides

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: nil, action: nil)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI

extension BaseNavigationController {

    func setupUI() {
        view.backgroundColor = .white
        navigationBar.barTintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor(hexString: "#ff7675")
        navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                                             .foregroundColor: UIColor(hexString: "#ff7675") ?? .black]
    }
}
