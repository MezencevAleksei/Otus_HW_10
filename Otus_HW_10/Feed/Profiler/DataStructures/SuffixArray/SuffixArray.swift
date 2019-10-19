//
//  SuffixArray.swift
//  Otus_HW_4
//
//  Created by alex on 08/07/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

struct SuffixIterator: IteratorProtocol{
    let string: String
    let last: String.Index
    var offset: String.Index
    
    
    init(string:String){
        self.string = string
        last = string.endIndex
        offset = string.startIndex
    }
    
    mutating func next() -> Substring?{
    
        guard offset < last else {return nil}
        
        let substring:Substring = string[offset..<last]
        string.formIndex(after: &offset)
        return substring
    }
}

struct SuffixSequence:Sequence{
    
    let string:String
    
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: string)
    }
}
