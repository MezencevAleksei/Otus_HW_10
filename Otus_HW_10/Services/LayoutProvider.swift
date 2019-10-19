//
//  LayoutProvider.swift
//  Otus_HW_3
//
//  Created by alex on 19/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

final class LayoutProvider {
    private var arrayOfItem:[StagLayout] = [StagLayout]()
    private let itemCount = 3
    private var currentItem = 0
    
    init(){
            let stagLayout = StagLayout(widthHeightRatios: [(0.5,0.5),(0.5,0.5),(0.5,1),(0.5,0.5),(0.5,0.5)], itemSpacing: 5)
            arrayOfItem.append(stagLayout)
            let stagLayout2 = StagLayout(widthHeightRatios: [(0.3,0.3),(0.7,0.3),(0.6,0.6),(0.4,0.6),(1,0.3)], itemSpacing: 1)
            arrayOfItem.append(stagLayout2)
            let stagLayout3 = StagLayout(widthHeightRatios: [(1.0, 1.0), (0.5, 0.5), (0.5, 1.5), (0.5, 1.0)], itemSpacing: 3)
            arrayOfItem.append(stagLayout3)
    }
    
    func getLayout()-> StagLayout {
        currentItem = currentItem >= itemCount - 1 ? 0 : currentItem + 1
        return arrayOfItem[currentItem]
    }
    

    
}
