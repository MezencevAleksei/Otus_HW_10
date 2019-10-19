//
//  CustomeTimerView.swift
//  Otus_HW_3
//
//  Created by alex on 17/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import UIKit


final class CustomeTimerView: UICollectionViewCell {
    static let reuseID = String(describing: CustomeTimerView.self)
    static let nib = UINib(nibName: String(describing: CustomeTimerView.self), bundle: nil)
    
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var PieChartView: PieChartView!
    var model: TimerCellModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.gray
        updateUI()
    }
    
    private func updateUI(){
        if self.model != nil {
            PieChartView.slices = self.model!.getSliceArrayForPieChart()
        }
        updateTime()
    }
    
    private func updateTime(){
        if self.model != nil {
            timerLabel.text = model?.getTimerLabelText()
        }
    }
    
    func didSelected(){
        if model == nil {return}
        model!.startStopTimer()
        updateUI()
    }
    
    func removeTimer(){
        if model == nil {return}
        model!.removeTimer()
        updateUI()
    }
    
    func startAnimate(){
        //PieChartView?.startAnimate()
    }
    
}

protocol UpdateViewCellDelegat {
    func update()
    func updateTimerLabel()
}

extension CustomeTimerView: UpdateViewCellDelegat {
    func update() {
        updateUI()
    }
    
    func updateTimerLabel(){
        updateTime()
    }
}
