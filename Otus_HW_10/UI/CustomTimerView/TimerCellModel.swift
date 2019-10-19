//
//  TimerCellModel.swift
//  Otus_HW_3
//
//  Created by alex on 19/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation
import UIKit



class TimerCellModel{
    
    private var timerLabelText:String = "0.0"
    private var timer: Timer?
   
    private var timeCounter: CGFloat = 0.0 {
        didSet{
            updateTimerLabel()
            cellDelegate?.updateTimerLabel()
        }
    }
    
    private var timePauseCounter: CGFloat = 0.0 
    
    var active:Bool = false
    
    var cellDelegate: UpdateViewCellDelegat?
    
    init(){
        initTimer()
    }
    
    func initTimer(){
        timerLabelText = "0.0"
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in if self.active {self.timeCounter = self.timeCounter + 0.1} else { self.timePauseCounter = self.timePauseCounter + 0.1}} )
        active = false
    }
    
    private func updateTimerLabel(){
        timerLabelText = String(format:"%.1f", timeCounter)
    }
    
    private func startTimer(){
        active = true
    }
    
    private func startPauseTimer(){
        active = true
    }
    
    private func stopTimer(){
        active = false
    }
    
    private func invalidateTimer(){
        timer?.invalidate()
        active = false
    }
    
    
    func getTimerLabelText()->String{
        return timerLabelText
    }
    
    func getActive()->Bool{
        return active
    }
    
    func startStopTimer(){
        if active {
            stopTimer()
        }else{
            startTimer()
        }
    }
    
    func removeTimer(){
        invalidateTimer()
        self.timeCounter = 0.0
        self.timePauseCounter = 0.0
    }
    
    func getSliceArrayForPieChart()->[Slice]{
        var array = [Slice]()
        let activeSlice = Slice(color: UIColor.green, value: self.timeCounter, title: String(format:"%.1f", self.timeCounter))
        let inActiveSlice = Slice(color: UIColor.red, value: self.timePauseCounter, title: String(format:"%.1f", self.timePauseCounter))

        array.append(activeSlice)
        array.append(inActiveSlice)
        return array
    }
}


