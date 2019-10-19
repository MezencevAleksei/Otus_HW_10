//
//  Profiler.swift
//  Otus_HW_4
//
//  Created by alex on 14/07/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

class Profiler {
    class func runClosureForTime(_ closure: (() -> Void)!) -> TimeInterval {
        //Timestamp before
        let startDate = Date()
        
        //Run the closure
        closure()
        
        //Timestamp after
        let endDate = Date()
        
        //Calculate the interval.
        let interval = endDate.timeIntervalSince(startDate)
        
        return interval
    }
}
