//
//  Decoder.swift
//  Do-ItCore
//
//  Created by Michael Pangburn on 3/13/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public protocol Decoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

extension JSONDecoder: Decoder {}
