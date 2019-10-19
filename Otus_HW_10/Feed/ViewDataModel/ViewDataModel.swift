//
//  ViewDataModel.swift
//  Otus_HW_12
//
//  Created by alex on 13.10.2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

struct ViewDataModel: Codable {
    let creationTime: TimeInterval
    let insertNewObject: TimeInterval
    let lookupByObject: TimeInterval
    let lookupBy10RandomeString: TimeInterval
    let lookupAllAlgo: TimeInterval
    let lookupForSpecifiedNumber: TimeInterval
}
