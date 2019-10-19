//
//  File.swift
//  Otus_HW_3
//
//  Created by alex on 15/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import Foundation

import UIKit

struct FeedData: Equatable {
    let name: String
}

final class FeedDataProvider {
    private var arrayOfItem:[FeedData] = [FeedData]()
    private let itemCount = 20
    private var suffixArray = [(suffix:String,feedData:FeedData)]()
    
    init(){
        arrayOfItem = [
            FeedData(name: "SuffixArray"),
            FeedData(name: "Array"),
            FeedData(name: "Set"),
            FeedData(name: "Dictionary"),
            FeedData(name: "Item 5"),
            FeedData(name: "Item 6"),
            FeedData(name: "Item 7"),
            FeedData(name: "Item 8"),
            FeedData(name: "Item 9"),
            FeedData(name: "Item 10"),
            FeedData(name: "Item 11"),
            FeedData(name: "Item 12"),
            FeedData(name: "Item 13"),
            FeedData(name: "Item 14"),
            FeedData(name: "Item 15"),
            FeedData(name: "Item 16"),
            FeedData(name: "Item 17"),
            FeedData(name: "Item 18"),
            FeedData(name: "Item 19"),
            FeedData(name: "Item 20"),
        ]
        updateSuffixArray()
    }
    
    func count()-> Int {
        return arrayOfItem.count
    }
    
    func itemFor(index: Int )-> FeedData?{
        if index <= arrayOfItem.count {
            return arrayOfItem[index]
        }
        return nil
    }
    
    func allItems() -> [FeedData]{
        return arrayOfItem
    }
}


//MARK: suffixArray search
extension FeedDataProvider{
    func findFeedDataByFeedName(_ findString: String)->[FeedData]{
        let findArray = suffixArray.filter{ var result = false
                                            if $0.suffix.count >= findString.count
                                                {result = $0.suffix.contains(findString.lowercased())}
                                            else if $0.suffix.count < findString.count
                                                {result = false}
                                            return result
                                            }.map{$0.feedData}
        
        return findArray.removingDuplicates()
    }
    
    private func updateSuffixArray() {
        if suffixArray.count > 0 {
            suffixArray.removeAll()
        }

        for feedData in arrayOfItem {
            addSuffixToArrayFrom(feedData: feedData)
        }
        self.suffixArray.sort { $0.suffix > $1.suffix }
    }
    
    private func addSuffixToArrayFrom(feedData: FeedData){
        for suffix in SuffixSequence(string: feedData.name){
            self.suffixArray.append((suffix: String(suffix).lowercased(), feedData: feedData))
        }
    }
}
