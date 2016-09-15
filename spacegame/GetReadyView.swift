//
//  GetReadyView.swift
//  spacegame
//
//  Created by Tomer Ciucran on 1/21/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import UIKit

class GetReadyView: UIView {

    @IBOutlet var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("GetReadyView", owner: self, options: nil)
        view.frame = frame
        addSubview(view);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
