//
//  MainMenuView.swift
//  spacegame
//
//  Created by Tomer Ciucran on 1/21/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import UIKit

protocol MainMenuDelegate: class {
    func play()
    func rate()
    func rankings()
}

class MainMenuView: UIView {

    var delegate:MainMenuDelegate?
    
    @IBOutlet var view: UIView!    
    @IBOutlet weak var versionLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NSBundle.mainBundle().loadNibNamed("MainMenuView", owner: self, options: nil)
        view.frame = frame
        
        let nsObject: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
        let version = nsObject as! String
        
        versionLabel.text = "v\(version)"
        addSubview(view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func playButtonTapped(sender: AnyObject) {
        delegate?.play()
    }
    
    @IBAction func rateButtonTapped(sender: AnyObject) {
        delegate?.rate()
    }
    
    @IBAction func rankingsButtonTapped(sender: AnyObject) {
        delegate?.rankings()
    }
}
