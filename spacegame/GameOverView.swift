//
//  GameOverView.swift
//  spacegame
//
//  Created by Tomer Ciucran on 3/25/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import UIKit

protocol GameOverDelegate: class {
    func goToMainMenu()
    func replay()
}

class GameOverView: UIView {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var view: UIView!
    var delegate: GameOverDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("GameOverView", owner: self, options: nil)
        view.frame = frame
        addSubview(view)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func mainMenuButtonAction(_ sender: AnyObject) {
        delegate?.goToMainMenu()
    }
    
    @IBAction func replayButtonAction(_ sender: AnyObject) {
        delegate?.replay()
    }
}
