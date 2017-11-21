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
            let gameViewController = GameViewController()
            let navigationController = UINavigationController(rootViewController: gameViewController)
            contentViewController = navigationController
        }
    }
}
