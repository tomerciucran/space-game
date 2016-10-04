//
//  Constants.swift
//  spacegame
//
//  Created by Tomer Ciucran on 3/25/16.
//  Copyright © 2016 Tomer Ciucran. All rights reserved.
//

import Foundation
import UIKit

struct PhysicsCategory {
    static let None     : UInt32 = 0
    static let Spaceship: UInt32 = 0b1
    static let Meteor   : UInt32 = 0b10
}

let meteorArray = ["meteor1",
    "meteor2",
    "meteor3"]

let texts = ["Awesome!", "Keep it up!", "Excellent!", "Amazing!", "Good job!"]

let colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.orange, UIColor.purple, UIColor.yellow, UIColor.magenta, UIColor.cyan]

let MenuMusicSound = "menu-music.wav"
let GameMusicSound = "game-music.wav"
let ExplosionSound = "explosion.aif"
let SwooshSound = "swoosh.wav"
let GameOverSound = "game-over.wav"

let muteKey = "mute"
let SpyAgency = "Spy Agency"
let SpyAgencyAcademy = "Spy Agency Academy"
