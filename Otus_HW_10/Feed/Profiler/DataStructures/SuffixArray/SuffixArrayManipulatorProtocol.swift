//
//  SuffixArrayManipulatorProtocol.swift
//  Otus_HW_4
//
//  Created by alex on 10/07/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

protocol SuffixArrayManipulatorProtocol {
    func setupWithObjectCount(_ count: Int) -> TimeInterval
    func arrayHasObjects() -> Bool
    func insertNewObject() -> TimeInterval
    func lookupByObject()  -> TimeInterval
    func lookupBy10RandomeString() -> TimeInterval
    func lookupAllAlgo()  -> TimeInterval
}
