//
//  xibView.swift
//  Otus_HW_1
//
//  Created by alex on 05/06/2019.
//  Copyright © 2019 Mezencev Aleksei. All rights reserved.
//

import UIKit

@IBDesignable class XibView: UIView {

    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
   private  func configure(){
        let bundle = Bundle.main
        if let nib = bundle.loadNibNamed("XibView", owner: nil, options: nil),
            let _view = nib[0] as? UIView{
            addSubview(_view)
        }
    }
}
