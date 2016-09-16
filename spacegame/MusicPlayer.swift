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
    static let sharedInstance = MusicPlayer()
    
    private var player: AVAudioPlayer!
    private var volume: Float! {
        didSet {
            if #available(iOS 10.0, *) {
                player.setVolume(volume, fadeDuration: 0.5)
            } else {
                // Fallback on earlier versions
                player.volume = volume
            }
        }
    }
    
    private override init() {}
    
    func setupBackgroundPlayer(url: URL) {
        if player != nil {
            stop()
        }
        
        do {
            try player = AVAudioPlayer(contentsOf: url)
        } catch {
            print("Couldn't load music player")
        }
        UserDefaults.standard.bool(forKey: muteKey) ? (player.volume = 0.0) : (player.volume = 1.0)
        player.numberOfLoops = -1
        player.prepareToPlay()
    }
    
    func actionForSound(name: String) -> SKAction? {
        if !UserDefaults.standard.bool(forKey: muteKey) {
            return SKAction.playSoundFileNamed(name, waitForCompletion: false)
        }
        return nil
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
    
    func setVolume(value: Float) {
        volume = value
        
    }
}
