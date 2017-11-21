//
//  RootViewController.swift
//  DrawGame
//
//  Created by Carlos Villanueva Ousset on 10/29/17.
//  Copyright © 2017 Carlos Villanueva Ousset. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    fileprivate struct Time {
        static let fadeInOutContentViewController: TimeInterval = 0.4
    }
    
    enum ContentViewControllerType {
        case landing
    }
    
    fileprivate(set) var contentViewController: UIViewController? {
        didSet {
            if let newContentViewController = contentViewController {
                addChildViewController(newContentViewController)
                view.insertSubview(newContentViewController.view, at: 0)
                newContentViewController.view.snp.remakeConstraints { make in
                    make.edges.equalTo(view)
                }
                newContentViewController.didMove(toParentViewController: self)
            }
            self.setNeedsStatusBarAppearanceUpdate()
            
            if let oldContentViewController = oldValue {
                oldContentViewController.willMove(toParentViewController: nil)
                UIView.animate(withDuration: Time.fadeInOutContentViewController, animations: { () -> Void in
                    oldContentViewController.view.alpha = 0.0
                }, completion: { finished in
                    oldContentViewController.view.removeFromSuperview()
                    oldContentViewController.removeFromParentViewController()
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self
        view.backgroundColor = Theme.Colors.background
        edgesForExtendedLayout = UIRectEdge()
        extendedLayoutIncludesOpaqueBars = false
        
        contentViewController = LaunchViewController()
        
        // TODO: do logo animations here
        
        handleCurrentSessionState()
    }
    
    fileprivate func handleCurrentSessionState() {
        presentContentViewController(type: .landing)
    }
    
    func presentContentViewController(type: ContentViewControllerType) {
        switch type {
        case .landing:
            let testGame = Game.forTest(type: .justCreatedByMe)
            let gameViewController = GameViewController(game: testGame)
            let navigationController = UINavigationController(rootViewController: gameViewController)
            contentViewController = navigationController
        }
    }
}



extension Game {
    enum TestGameType {
        case justCreatedByMe
        case myTurnToGuess(iAmPlayerA: Bool)
        case notMyTurn(iAmPlayerA: Bool)
    }
    
    static func forTest(type: TestGameType) -> Game {
        let width = 256
        let height = 256
        var pixels: [Pixel] = []
        for i in 0..<(width * height) {
            let isTop = i <= (width * height) / 2
            if isTop {
                pixels.append(Pixel(r: 0, g: 0, b: 255))
            } else {
                pixels.append(Pixel(r: 0, g: 255, b: 0))
            }
        }
        
        let playerAId: String
        let playerBId: String?
        let isPlayerATurn: Bool
        let playerAScore: Int
        let playerBScore: Int
        switch type {
        case .justCreatedByMe:
            playerAId = Api.udid
            playerBId = nil
            isPlayerATurn = true
            playerAScore = 0
            playerBScore = 0
        case .myTurnToGuess(let iAmPlayerA):
            playerAId = iAmPlayerA ? Api.udid : "otherUserId"
            playerBId = iAmPlayerA ? "otherUserId" : Api.udid
            isPlayerATurn = iAmPlayerA
            playerAScore = 2
            playerBScore = 2
        case .notMyTurn(let iAmPlayerA):
            playerAId = iAmPlayerA ? Api.udid : "otherUserId"
            playerBId = iAmPlayerA ? "otherUserId" : Api.udid
            isPlayerATurn = !iAmPlayerA
            playerAScore = 2
            playerBScore = 2
        }

        let drawing = Drawing(pixels: pixels, width: width, height: height, word: "house")
        let game = Game(id: "123", playerAId: playerAId, playerBId: playerBId, drawing: drawing, isPlayerATurn: isPlayerATurn, playerAScore: playerAScore, playerBScore: playerBScore)
        
        return game
    }
}









