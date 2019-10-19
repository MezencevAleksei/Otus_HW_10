//
//  ViewControllerDataCaching.swift
//  Otus_HW_12
//
//  Created by alex on 13.10.2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerDataCaching: ViewControllerLifecycleBehavior{

    func beforeDisappearing(_ viewController: UIViewController) {
        //Сохраним данные View в кэш
        guard let vc = viewController as? SuffixArrayViewController else {return}
        
        let viewData: ViewDataModel = ViewDataModel(creationTime: vc.creationTime, insertNewObject: vc.insertNewObject, lookupByObject: vc.lookupByObject, lookupBy10RandomeString: vc.lookupBy10RandomeString, lookupAllAlgo: vc.lookupAllAlgo, lookupForSpecifiedNumber: vc.lookupForSpecifiedNumber)
        
        Cache.store(viewData, to: .caches, as: "SuffixArrayViewDataCache")
    }
    
    func beforeAppearing(_ viewController: UIViewController) {
        //Востановим данные View из кэша
        guard let vc = viewController as? SuffixArrayViewController else {return}
        let viewDataOptional: ViewDataModel? = Cache.retrieve("SuffixArrayViewDataCache", from: .caches, as: ViewDataModel.self)
        if let viewData = viewDataOptional {
            vc.creationTime = viewData.creationTime
            vc.insertNewObject = viewData.insertNewObject
            vc.lookupByObject = viewData.lookupByObject
            vc.lookupBy10RandomeString = viewData.lookupBy10RandomeString
            vc.lookupAllAlgo = viewData.lookupAllAlgo
            vc.lookupForSpecifiedNumber = viewData.lookupForSpecifiedNumber
        }
    }
    
}
