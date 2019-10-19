//
//  ShareExtensionViewController.swift
//  Otus_HW_6
//
//  Created by alex on 26/07/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import UIKit

class ShareExtensionViewController: UIViewController {

    
    private let parser = Parser()
    @IBOutlet weak var LanguageSegment: UISegmentedControl!
    
    @IBOutlet weak var textLabel: UILabel!
    var text: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upadateText()
    }
    
    private func upadateText(){
        if text != nil {
            languageDidChange(self)
        }
    }
    
    @IBAction func languageDidChange(_ sender: Any) {
        var local:MyLocal = .fr
        
        if LanguageSegment.selectedSegmentIndex == 0 {
            local = .fr
        }else if LanguageSegment.selectedSegmentIndex == 1 {
            local = .en
        }else if LanguageSegment.selectedSegmentIndex == 2 {
            local = .zh
        }

        if var _text = self.text {
            parser.replaceDateInString(string: &_text, locale: local)
            parser.replaceUnitInString(string: &_text, locale: local)
            textLabel.text = _text
        }
    }
   

}
