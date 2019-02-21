//
//  UITableView.swift
//  Do-It
//
//  Created by Michael Pangburn on 2/20/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNib(for type: NibLoadable.Type) {
        register(type.nib(), forCellReuseIdentifier: type.className)
    }

    func registerNibs(for types: NibLoadable.Type...) {
        types.forEach(registerNib)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, as type: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable cell of type \(T.self)")
        }
        return cell
    }
}
