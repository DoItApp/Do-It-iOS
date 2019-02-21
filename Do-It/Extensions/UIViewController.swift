//
//  UIViewController.swift
//  Do-It
//
//  Created by Michael Pangburn on 2/21/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
    static func instantiateFromStoryboard() -> (UINavigationController?, Self)
}

extension UIViewController: IdentifiableClass {}
extension UIViewController: StoryboardInstantiable {}

extension StoryboardInstantiable where Self: UIViewController {
    static func instantiateFromStoryboard() -> (UINavigationController?, Self) {
        let storyboardName = className
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("No initial view controller defined for \(storyboard)")
        }

        if let expectedViewController = initialViewController as? Self {
            return (nil, expectedViewController)
        } else if let outerNavigationController = initialViewController as? UINavigationController,
            let expectedViewController = outerNavigationController.viewControllers.first as? Self {
            return (outerNavigationController, expectedViewController)
        } else {
            fatalError("""
                Unexpectedly found \(type(of: initialViewController)) in \(storyboard) where \(className) was expected
                """)
        }
    }
}
