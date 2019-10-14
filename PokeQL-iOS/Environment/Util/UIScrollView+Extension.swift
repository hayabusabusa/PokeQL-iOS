//
//  UIScrollView+Extension.swift
//  Holder
//
//  Created by Yamada Shunya on 2019/09/11.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit

extension UIScrollView {

    // swiftlint:disable:next override_in_extension
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.next?.touchesBegan(touches, with: event)
    }
}
