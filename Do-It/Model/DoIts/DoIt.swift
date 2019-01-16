//
//  DoIt.swift
//  Do-It
//
//  Created by Michael Pangburn on 11/15/18.
//  Copyright © 2018 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

protocol DoIt {
    var id : DoItId { get }
    
    var course: Course { get set }
    var dueDate: Date { get set }
    var description: String { get set }
    var name: String { get set }
    var priority: DoItPriority { get set }
}
