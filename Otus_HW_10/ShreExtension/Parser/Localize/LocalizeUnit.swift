//
//  LocalizeUnit.swift
//  Otus_HW_6
//
//  Created by alex on 11/08/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

final class LocalizeUnit {
    
    var curentLocale: Locale?
    private var formatter: MeasurementFormatter
    
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = [.naturalScale]
    }
    
    
    func convertUnit(value: Double, unit: UnitLength, to locale:MyLocal) -> String{
        formatter.locale = locale.getLocal()
        let fromMeasurement = Measurement(value: value, unit: unit)
        return formatter.string(from: fromMeasurement)
    }


}
