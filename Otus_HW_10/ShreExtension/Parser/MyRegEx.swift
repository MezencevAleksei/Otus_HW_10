//
//  MyRegEx.swift
//  Otus_HW_6
//
//  Created by alex on 29/07/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

final class Parser{
    
    var arrayOfDatePattern = [(datePatern:String, dateFormate:String)]()
    var arrayOfUnitPattern = [(unitPatern:String, uniteLength: UnitLength)]()
    
    private let localDateClass = LocalizeDate()
    private let localUnitClass = LocalizeUnit()
    private var replacedDateStrings = [String]()
    
    
    init(){
        
        //DATE
        //01 января 2019
        let datePattern = #"[0-9]{2}(\s)?\ ((я|Я)нваря|(ф|Ф)евраля|(м|М)арта|(а|А)преля|(м|М)ая|(и|И)юня|(и|И)юля|(а|А)вгуста|(с|С)ентября|(о|О)ктября|(н|Н)оября|(д|Д)екабря)(\s)?([0-9]{2,4})"#
        let dateFomat = "dd MMMM yyyy"
        
        //01 января 19
        let datePattern1 = #"[0-9]{1,2}(\s)?\ ((я|Я)нваря|(ф|Ф)евраля|(м|М)арта|(а|А)преля|(м|М)ая|(и|И)юня|(и|И)юля|(а|А)вгуста|(с|С)ентября|(о|О)ктября|(н|Н)оября|(д|Д)екабря)(\s)?([0-9]{2})"#
        let dateFomat1 = "dd MMMM yy"
        
        //01.01.2019
        let datePattern2 = #"[0-9]{1,2}\.[0-9]{2}\.[0-9]{4}"#
        let dateFomat2 = "dd.MM.yyyy"
        
        //01.01.19
        let datePattern21 = #"[0-9]{1,2}\.[0-9]{2}\.[0-9]{2}"#
        let dateFomat21 = "dd.MM.yy"
        
        //01-01-2019
        let datePattern3 = #"[0-9]{1,2}\-[0-9]{2}\-[0-9]{4}"#
        let dateFomat3 = "dd-MM-yyyy"
        
        //01-01-19
        let datePattern31 = #"[0-9]{1,2}\-[0-9]{2}\-[0-9]{2}"#
        let dateFomat31 = "dd-MM-yy"
        
        //01/01/2019
        let datePattern4 = #"[0-9]{1,2}\/[0-9]{2}\/([0-9]{4})"#
        let dateFomat4 = "dd/MM/yyyy"
        
        //01/01/19
        let datePattern41 = #"[0-9]{1,2}\/[0-9]{2}\/([0-9]{2})"#
        let dateFomat41 = "dd/MM/yy"
        
        //01 01 2019
        let datePattern5 = #"[0-9]{1,2}\s+[0-9]{2}\s+[0-9]{4}"#
        let dateFomat5 = "dd MM yyyy"
        
        arrayOfDatePattern.append((datePatern: datePattern, dateFormate: dateFomat))
        arrayOfDatePattern.append((datePatern: datePattern1, dateFormate: dateFomat1))
        arrayOfDatePattern.append((datePatern: datePattern2, dateFormate: dateFomat2))
        arrayOfDatePattern.append((datePatern: datePattern21, dateFormate: dateFomat21))
        arrayOfDatePattern.append((datePatern: datePattern3, dateFormate: dateFomat3))
        arrayOfDatePattern.append((datePatern: datePattern31, dateFormate: dateFomat31))
        arrayOfDatePattern.append((datePatern: datePattern4, dateFormate: dateFomat4))
        arrayOfDatePattern.append((datePatern: datePattern41, dateFormate: dateFomat41))
        arrayOfDatePattern.append((datePatern: datePattern5, dateFormate: dateFomat5))
       
        //Length
        let unitPaternMicrometers = #"[0-9]*(\.|,)?[0-9]*(\s)?(микрометр|микрометра|микрометров|мкм)"#
        let unitLengthMicrometers = UnitLength.micrometers
        
        let unitPaternMillimeters = #"[0-9]*(\.|,)?[0-9]*(\s)?(миллиметр|миллиметра|миллиметров|мм)"#
        let unitLengthMillimeters = UnitLength.millimeters
        
        let unitPaternCentimeters = #"[0-9]*(\.|,)?[0-9]*(\s)?(сантиметр|сантиметра|сантиметров|см)"#
        let unitLengthCentimeters = UnitLength.centimeters
        
        let unitPaternDecimeters = #"[0-9]*(\.|,)?[0-9]*(\s)?(дециметр|дециметра|дециметров|дм)"#
        let unitLengthDecimeters = UnitLength.decimeters
        
        let unitPaternMeters = #"[0-9]*(\.|,)?[0-9]*(\s)?(метр|метра|метров|м)"#
        let unitLengthMeters = UnitLength.meters
        
        let unitPaternKilometers = #"[0-9]*(\.|,)?[0-9]*(\s)?(километр|километра|километров|км)"#
        let unitLengthKilometers = UnitLength.kilometers

        arrayOfUnitPattern.append((unitPatern:unitPaternMicrometers, uniteLength: unitLengthMicrometers))
        arrayOfUnitPattern.append((unitPatern:unitPaternMillimeters, uniteLength: unitLengthMillimeters))
        arrayOfUnitPattern.append((unitPatern:unitPaternCentimeters, uniteLength: unitLengthCentimeters))
        arrayOfUnitPattern.append((unitPatern:unitPaternDecimeters, uniteLength: unitLengthDecimeters))
        arrayOfUnitPattern.append((unitPatern:unitPaternMeters, uniteLength: unitLengthMeters))
        arrayOfUnitPattern.append((unitPatern:unitPaternKilometers, uniteLength: unitLengthKilometers))

    }
    
    
   
    func replaceDateInString(string: inout String, locale: MyLocal){
        replacedDateStrings.removeAll()
        for element in arrayOfDatePattern {
            let result = search(stringForSearch: string, regexPattern: element.datePatern)
            if result.count > 0 {
                for findedElement in result {
    
                    if let convertedDate = localDateClass.convertToDate(dateString: findedElement.string, dateFormate: element.dateFormate){
                        
                        var gotMatch = false
                        for str in replacedDateStrings{
                            if str.contains(findedElement.string){
                                gotMatch = true
                            }
                        }
                        if !gotMatch {
                            let convertedDateString = localDateClass.dateToLocaleDateString(date: convertedDate, _local: locale)

                            replaceRangeInString(str: &string, range: findedElement.range, replaceStr: convertedDateString)
                            replacedDateStrings.append(findedElement.string)
                        }
                    }
                }
            }
        }
    }
    
    
    func replaceUnitInString(string: inout String, locale: MyLocal){
        for element in arrayOfUnitPattern {
            let result = search(stringForSearch: string, regexPattern: element.unitPatern)
            if result.count > 0 {
                for findedElement in result {
                    
                    let resultNumbString = findedElement.string.filter("01234567890.,".contains)
                    if let resultDigit = Double(resultNumbString){
                        let convertedUnitString = localUnitClass.convertUnit(value: resultDigit, unit: element.uniteLength, to: locale)
                        replaceRangeInString(str: &string, range: findedElement.range, replaceStr: convertedUnitString)
                    }
                }
            }
        }
    }
    
    private func replaceRangeInString(str: inout String, range: NSRange, replaceStr: String){
        str.replaceSubrange(Range(range, in: str)!, with: replaceStr)
    }

    private func search(stringForSearch:String, regexPattern:String) -> [(string:String, range: NSRange)] {
        var findedSubSrtings = [(string:String, range: NSRange)]()
        do {
            let regex = try NSRegularExpression(pattern: regexPattern)
            let searchStringRange = NSRange(stringForSearch.startIndex..., in: stringForSearch)
            let results = regex.matches(in: stringForSearch, range:searchStringRange )
            
            findedSubSrtings = results.map {
                let str = String(stringForSearch[Range($0.range, in: stringForSearch)!])
                return (string: str, range: $0.range)
            }
        }  catch let error {
            print("error \(error)")
        }
        return findedSubSrtings
    }
    
    
    
}
