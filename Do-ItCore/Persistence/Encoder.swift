//
//  Encoder.swift
//  Do-ItCore
//
//  Created by Michael Pangburn on 3/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public protocol Encoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONEncoder: Encoder {}
