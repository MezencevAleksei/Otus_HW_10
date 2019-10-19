//
//  BenchmarkViewModel.swift
//  Otus_HW_6
//
//  Created by alex on 20/08/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

class BenchmarkViewModel{
    let benchmarkModel:BenchmarkModel  = BenchmarkModel()
    let layoutProvider:LayoutProvider = {
        if let service: LayoutProvider = ServiceLocator.shared.getService() {
            return service
        } else {
            fatalError()
        }
    }()
    var TimerModels = [IndexPath:TimerCellModel]()

    func getLayout()-> StagLayout {
        return layoutProvider.getLayout()
    }
    
    func getCountOfItemInCollectionView()-> Int{
        return benchmarkModel.getCountOfItemInCollectionView()
    }
    
    

   
    func setupeCell( timerCell: inout CustomeTimerView, at indexPath: IndexPath) {
        if let timerModel = TimerModels[indexPath] {
            timerModel.cellDelegate = timerCell
            timerCell.model = timerModel
        }else{
            let newTimerModel = TimerCellModel()
            newTimerModel.cellDelegate = timerCell
            timerCell.model     = newTimerModel
        }
    }
}
