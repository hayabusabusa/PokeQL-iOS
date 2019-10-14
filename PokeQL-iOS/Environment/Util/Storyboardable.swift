//
//  Storyboardable.swift
//  Holder
//
//  Created by Yamada Shunya on 2019/09/03.
//  Copyright © 2019 山田隼也. All rights reserved.
//
import UIKit

protocol Storyboardable {

}

extension Storyboardable where Self: UIViewController {

    static func instantiateWithStoryboard() -> Self {
        let nameType = String(describing: type(of: self))
        let storyboardName = String(describing: nameType).components(separatedBy: ".")[0]
        return UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateInitialViewController() as! Self // swiftlint:disable:this force_cast
    }

    static func newInstance() -> Self {
        return instantiateWithStoryboard()
    }
}
