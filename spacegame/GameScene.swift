//
//  GameScene.swift
//  spacegame
//
//  Created by Tomer Ciucran on 1/18/16.
//  Copyright (c) 2016 Tomer Ciucran. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate: class {
    func showGameOver()
}

struct Lanes {
    static let Left = UIScreen.main.bounds.width/6
    static let Middle = UIScreen.main.bounds.width/2
    static let Right = UIScreen.main.bounds.width*(5/6)
}

class GameScene: SKScene, SKPhysicsContactDelegate, MainMenuDelegate, GameOverDelegate {
    
    var gsDelegate: GameSceneDelegate?
    var spaceShip: SpaceShipNode!
    var gas: SKEmitterNode!
    let bg = SKSpriteNode(imageNamed: "bg")
    var visibleMeteors = [SKSpriteNode]()
    var isGameOver = false
    var isGetReadyScreenVisible = false
    var isGameStarted = false
    var mainMenuView:MainMenuView!
    var getReadyView:GetReadyView!
    var gameOverView:GameOverView!
    var scoreLabel: SKLabelNode!
    var timer = Timer()
    var score: Double = 0
    var scoreText: String?
    var leftLaneCount = 0
    var middleLaneCount = 0
    var rightLaneCount = 0
    
    override func didMove(to view: SKView) {
        setupView(true)
    }
    
    func updateTimer() {
        if !isGameStarted { return }
        score += 1
        if score >= 1000 {
            let km = score/1000
            scoreLabel.text = String(format: "%.2f km", arguments: [km])
        } else {
            scoreLabel.text = "\(Int(score)) m"
        }
        scoreText = scoreLabel.text
        
        if score.truncatingRemainder(dividingBy: 1000) == 0 {
            animateScoreLabel()
        }
    }
    
    func setupMainMenu() {
        mainMenuView = MainMenuView(frame: (view?.bounds)!)
        mainMenuView.delegate = self
        view?.addSubview(mainMenuView)
    }
    
    func setupGetReadyScreen() {
        getReadyView = GetReadyView(frame: (view?.bounds)!)
        view?.addSubview(getReadyView)
    }
    
    func setupGameOverView() {
        gameOverView = GameOverView(frame: (view?.bounds)!)
        gameOverView.delegate = self
        view?.addSubview(gameOverView)
    }
    
    func setupView(_ firstTime: Bool) {
        if firstTime {
            setupMainMenu()
            setupGetReadyScreen()
            setupGameOverView()
            getReadyView.toggleView(false, show: false, completion: nil)
            gameOverView.toggleView(false, show: false, completion: nil)
            isGetReadyScreenVisible = false
            isGameOver = false
            isGameStarted = false
            
            var emitterNode = StarfieldNode.initialize(frame, color: SKColor.lightGray, starSpeedY: 50, starsPerSecond: 1, starScaleFactor: 0.2)
            emitterNode.zPosition = -10
            addChild(emitterNode)
            
            emitterNode = StarfieldNode.initialize(frame, color: SKColor.gray, starSpeedY: 30, starsPerSecond: 2, starScaleFactor: 0.1)
            emitterNode.zPosition = -11
            addChild(emitterNode)
            
            emitterNode = StarfieldNode.initialize(frame, color: SKColor.darkGray, starSpeedY: 15, starsPerSecond: 4, starScaleFactor: 0.05)
            emitterNode.zPosition = -12
            addChild(emitterNode)
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(GameScene.updateTimer), userInfo: nil, repeats: true)
        
        scoreLabel = SKLabelNode(fontNamed: "Spy Agency")
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 20, y: size.height - 40)
        addChild(scoreLabel)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        bg.zPosition = -13
        bg.size = frame.size
        bg.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bg)
        
        spaceShip = SpaceShipNode(position: CGPoint(x: size.width * 0.5, y: size.height * 0.17), color: UIColor.clear, size: CGSize(width: 151, height: 152))
        addChild(spaceShip)
        
        if let gasNode = SKEmitterNode(fileNamed: "GasParticle.sks") {
            gasNode.position = CGPoint(x: 0, y: -spaceShip.size.height + 10)
            gasNode.zPosition = -1
            spaceShip.addChild(gasNode)
            gas = gasNode
        }
    }
    
    func getRandomLane() -> CGFloat {
        let lane = Util.random(0..<2)
        switch lane {
        case 0:
            if leftLaneCount <= 2 {
                leftLaneCount += 1
                return Lanes.Left
            } else {
                return getRandomLane()
            }
        case 1:
            if middleLaneCount <= 2 {
                middleLaneCount += 1
                return Lanes.Middle
            } else {
                return getRandomLane()
            }
        case 2:
            if rightLaneCount <= 2 {
                rightLaneCount += 1
                return Lanes.Right
            } else {
                return getRandomLane()
            }
        default:
            break
        }
        return 0
    }
    
    func animateScoreLabel() {
        let label = SKLabelNode(fontNamed: "Spy Agency Academy")
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: frame.midX, y: frame.midY + 20)
        label.text = "\(Int(score/1000)) km"
        label.fontColor = UIColor.white
        label.setScale(0.4)
        label.blendMode = .multiply
        label.alpha = 0
        addChild(label)
        
        let label2 = label.copy() as! SKLabelNode
        let texts = ["Awesome!", "Keep it up!", "Excellent!", "Amazing!", "Good job!"]
        label2.position = CGPoint(x: frame.midX, y: frame.midY - 20)
        label2.text = texts[Int(Util.random(0..<4))]
        label2.fontColor = UIColor.white
        addChild(label2)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 0.2)
        let increaseSizeAction = SKAction.scale(to: 1.4, duration: 0.2)
        let waitAction = SKAction.wait(forDuration: 0.6)
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        
        label.run(increaseSizeAction)
        label.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction]), completion: {
            label.removeFromParent()
        }) 
        
        label2.run(increaseSizeAction)
        label2.run(SKAction.sequence([fadeInAction, waitAction, fadeOutAction]), completion: {
            label2.removeFromParent()
        }) 
    }
    
    func addMeteor() {
        
        let meteor = SKSpriteNode(imageNamed: meteorArray[Int(Util.random(min: 0, max: 2))])
        let actualX: CGFloat
        actualX = getRandomLane()

        meteor.position = CGPoint(x: actualX, y: size.height + meteor.size.height)
        meteor.physicsBody = SKPhysicsBody(circleOfRadius: meteor.size.width/2)
        meteor.physicsBody?.isDynamic = true
        meteor.physicsBody?.categoryBitMask = PhysicsCategory.Meteor
        meteor.physicsBody?.contactTestBitMask = PhysicsCategory.Spaceship
        meteor.physicsBody?.collisionBitMask = PhysicsCategory.None
        meteor.physicsBody?.usesPreciseCollisionDetection = true
        meteor.setScale(0.6)
        addChild(meteor)
        let actualDuration = Util.random(min: CGFloat(2.0), max: CGFloat(5.0))
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -meteor.size.width/2), duration: TimeInterval(actualDuration))
        let actionRotate = SKAction.rotate(byAngle: CGFloat(M_PI), duration:Double(Util.random(min: 1, max: 4)))
        let actionMoveDone = SKAction.removeFromParent()
        meteor.run(SKAction.repeatForever(actionRotate))
        meteor.run(SKAction.sequence([actionMove, actionMoveDone]), completion: { () -> Void in
            if actualX == Lanes.Left {
                self.leftLaneCount -= 1
            } else if actualX == Lanes.Middle {
                self.middleLaneCount -= 1
            } else {
                self.rightLaneCount -= 1
            }
        }) 
        
        visibleMeteors.append(meteor)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Spaceship != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Meteor != 0)) {
                spaceshipDidCollideWithMeteor(firstBody.node as! SKSpriteNode, meteor: secondBody.node as! SKSpriteNode, contactPoint: contact.contactPoint)
        }
    }
    
    func spaceshipDidCollideWithMeteor(_ spaceship:SKSpriteNode, meteor:SKSpriteNode, contactPoint: CGPoint) {
        
        if isGameOver { return }
        timer.invalidate()
        spaceship.removeAllActions()
        explosion(contactPoint) { 
            self.gameOverView.toggleView(true, show: true) { () -> Void in }
            spaceship.removeFromParent()
            meteor.removeFromParent()
        }
        self.isGameOver = true
        self.isGameStarted = false
        self.gameOverView.scoreLabel.text = self.scoreText
    }
    
    // MARK: - GameOverDelegate
    
    func goToMainMenu() {
        gameOverView.toggleView(true, show: false) { () -> Void in
            self.mainMenuView.toggleView(true, show: true, completion: nil)
            self.isGameOver = true
            self.isGameStarted = false
            self.isGetReadyScreenVisible = false
            self.restart()
        }
    }
    
    func replay() {
        gameOverView.toggleView(true, show: false) { () -> Void in
            self.getReadyView.toggleView(true, show: true, completion: nil)
            self.isGameOver = true
            self.isGameStarted = false
            self.isGetReadyScreenVisible = true
            self.restart()
        }
    }
    
    // MARK: - MainMenuDelegate
    
    func play() {
        mainMenuView.toggleView(true, show: false) { () -> Void in
            self.getReadyView.toggleView(true, show: true, completion: { () -> Void in
                self.isGetReadyScreenVisible = true
            })
        }
    }
    
    func rate() {
        
    }
    
    func rankings() {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        if isGetReadyScreenVisible {
            getReadyView.toggleView(true, show: false, completion: { () -> Void in
                self.isGetReadyScreenVisible = false
                self.isGameStarted = true
                self.isGameOver = false
                self.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.run(self.addMeteor),
                        SKAction.wait(forDuration: 1.5)
                        ])
                    ))
            })
        } else {
            if isGameOver { return }
            spaceShip.screenTapAction(touchLocation)
        }
    }
    
    func explosion(_ pos: CGPoint, completionHandler: @escaping () -> Void) {
        if let emitterNode = SKEmitterNode(fileNamed: "ExplosionParticle.sks") {
            emitterNode.particlePosition = pos
            emitterNode.zPosition = 2
            self.addChild(emitterNode)
            self.run(SKAction.wait(forDuration: 2), completion: { emitterNode.removeFromParent(); completionHandler() })
        }
    }
    
    func restart() {
        for node:SKSpriteNode in visibleMeteors {
            node.removeFromParent()
        }
        
        score = 0
        leftLaneCount = 0
        middleLaneCount = 0
        rightLaneCount = 0
        scoreLabel.removeFromParent()
        removeAllActions()
        visibleMeteors.removeAll()
        spaceShip.removeFromParent()
        gas.removeFromParent()
        bg.removeFromParent()
        setupView(false)
    }
}
