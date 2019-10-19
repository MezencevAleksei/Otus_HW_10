//
//  FeedTableViewCell.swift
//  Otus_HW_3
//
//  Created by alex on 15/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    static let reuseID = String(describing: FeedTableViewCell.self)
    static let nib = UINib(nibName: String(describing: FeedTableViewCell.self), bundle: nil)
    
    private var testTimeDouble:Double?
    @IBOutlet var itemLabel: UILabel!
    
    @IBOutlet weak var testTimeLabel: UILabel!
    
    @IBOutlet weak var testTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setVisible()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setTimeOfTest(time:Double){
        self.testTimeDouble = time
        setVisible()
        testTime.text = String(format:"%.4f", self.testTimeDouble!)
    }
    
    func setBackgroundColor(color: UIColor){
        self.backgroundColor = color
    }
    
    func update(labelText: String) {
        itemLabel.text = labelText
    }
    
    private func setVisible(){
        if self.testTimeDouble == nil {
            testTime.isHidden = true
            testTimeLabel.isHidden = true
        }else{
            testTime.isHidden = false
            testTimeLabel.isHidden = false
        }
    }
}
