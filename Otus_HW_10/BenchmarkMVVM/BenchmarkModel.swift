//
//  BenchmarkModel.swift
//  Otus_HW_7
//
//  Created by alex on 24/08/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

class BenchmarkModel{
   
    private var countOfItemInCollectionView: Int
    
    init(){
        self.countOfItemInCollectionView = 80
    }
    
    func getCountOfItemInCollectionView()->Int{
        return countOfItemInCollectionView
    }
}
