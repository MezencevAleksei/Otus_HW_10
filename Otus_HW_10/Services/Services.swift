//
//  Services.swift
//  Otus_HW_3
//
//  Created by alex on 15/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation


class Services {
    
    static var feedDataProvider: FeedDataProvider = {
        return FeedDataProvider()
    }()
    
    static var layoutProvider: LayoutProvider = {
       return LayoutProvider()
    }()
    
    static var stringGenerator: StringGenerator = {
        return StringGenerator()
    }()
    
    static var algoProvider: AlgoProvider = {
        return AlgoProvider()
    }()
}
