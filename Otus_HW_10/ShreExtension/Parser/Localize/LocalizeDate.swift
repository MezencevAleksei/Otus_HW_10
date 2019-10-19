//
//  Localize.swift
//  Otus_HW_6
//
//  Created by alex on 29/07/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

enum MyLocal{
    case en
    case fr
    case zh
    
    func getLocal()->Locale{
        if self == .en{
            return Locale(identifier: "en_US")
        }else if self == .fr{
            return Locale(identifier: "fr")
        }else if self == .zh{
            return Locale(identifier: "zh_CN")
        }
        return Locale(identifier: "ru_RU")
    }
}

final class LocalizeDate {
    
    var curentLocale: Locale?
    var dfEn:DateFormatter
    var dfFr:DateFormatter
    var dfZh:DateFormatter
    let dfRu:DateFormatter
    //let defaultDateFormate = "yyyy.MM.dd G 'at' HH:mm:ss zzz"
    let defaultDateFormate = "yyyy.MM.dd"


   init() {
        dfRu = DateFormatter()
        dfRu.locale = Locale(identifier: "ru_RU")
       
        let en = Locale(identifier: "en_US")
        let fr = Locale(identifier: "fr")
        let zh = Locale(identifier: "zh_CN")
    
        dfEn = DateFormatter()
        dfEn.locale = en
    
        dfFr = DateFormatter()
        dfFr.locale = fr

        dfZh = DateFormatter()
        dfZh.locale = zh
        
    }
    
    
    
    func convertToDate(dateString: String, dateFormate:String) -> Date?{
        if let date = stringToDate(TextDate:dateString, dateFormat: dateFormate) {
            return date
          }
        return nil
    }
    
    func dateToLocaleDateString(date: Date, _local: MyLocal)-> String {
        
        var resultDateString: String = ""
        if _local ==  .en {
            dfEn.setLocalizedDateFormatFromTemplate(defaultDateFormate)
            resultDateString = dfEn.string(from: date)
        }else if _local ==  .fr{
            dfFr.setLocalizedDateFormatFromTemplate(defaultDateFormate)
            resultDateString = dfFr.string(from: date)
        }else if _local ==  .zh{
            dfZh.setLocalizedDateFormatFromTemplate(defaultDateFormate)
            resultDateString = dfZh.string(from: date)
        }
        return resultDateString
    }

 
    
    private func stringToDate(TextDate:String, dateFormat: String)->Date?{

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat //"yyyy-MM-dd HH:mm:ss"
            dateFormatter.timeZone = TimeZone.current
            if let date = dateFormatter.date(from: TextDate)
            {
                return date
            }else{
                return nil
            }
    }
}
