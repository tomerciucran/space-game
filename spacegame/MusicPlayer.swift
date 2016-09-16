//
//  MusicPlayer.swift
//  spacegame
//
//  Created by Tomer Ciucran on 9/16/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import SpriteKit
import AVFoundation

class MusicPlayer: NSObject {
    var player: AVAudioPlayer!
    
    func setupBackgroundPlayer(url: URL) {
        if player != nil {
            stop()
        }
        
        do {
            try player = AVAudioPlayer(contentsOf: url)
        } catch {
            print("Couldn't load music player")
        }
        player.numberOfLoops = -1
    }
    
    func actionForSound(name: String) -> SKAction {
        return SKAction.playSoundFileNamed(name, waitForCompletion: false)
    }
    
    func play() {
        if !player.isPlaying {
            player.play()
        }
    }
    
    func stop() {
        if player.isPlaying {
            player.stop()
        }
    }
}
