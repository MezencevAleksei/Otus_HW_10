//
//  Extension.swift
//  Otus_HW_4
//
//  Created by alex on 15/07/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element: Equatable {
    func removingDuplicates() -> Array {
        return reduce(into: []) { result, element in
            if !result.contains(element) {
                result.append(element)
            }
        }
    }
}

extension UIColor {
    func getColorOfProcent(_ t: Double)->UIColor{
                
               let max:Double    = 100;
               
               let fromR:Double  = 0;
               let fromG:Double  = 255;
               let fromB:Double  = 0;
               
               let toR:Double    = 255.0;
               let toG:Double    = 0.0;
               let toB:Double    = 0.0;
               
               let deltaR = round(Double((toR - fromR) / max))
               let deltaG = round(Double((toG - fromG) / max))
               let deltaB = round(Double((toB - fromB) / max))
               
               let R      = fromR + t * deltaR
               let G      = fromG + t * deltaG
               let B      = fromB + t * deltaB
               let color = UIColor.init(red: CGFloat(R/255) , green: CGFloat(G/255), blue: CGFloat(B/255), alpha: 1.0)
               return color
    }
    
}
