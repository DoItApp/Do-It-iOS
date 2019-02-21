//
//  DoItSharingObserver.swift
//  Do-It
//
//  Created by Michael Pangburn on 1/31/19.
//  Copyright © 2019 The Swifter Picker-Uppers. All rights reserved.
//

import Foundation

public protocol DoItSharingObserver: AnyObject {
    func sharingManager(_ sharingManager: DoItSharingManager, didReceiveDoIts doIts: [DoIt])
}
