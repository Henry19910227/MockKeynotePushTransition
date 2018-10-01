//
//  HenryPopTransition.swift
//  MockKeynoteTest
//
//  Created by Henry.Liao on 2018/10/1.
//  Copyright © 2018 廖冠翰. All rights reserved.
//

import UIKit

class HenryPopTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let formVC = transitionContext.viewController(forKey: .from) as! TwoViewController
        
        
        let toVC = transitionContext.viewController(forKey: .to) as! OneViewController
        toVC.selectCell?.iconImageView.isHidden = true
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        
        let containerView = transitionContext.containerView
        
        let snapshotView = formVC.imageView.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = formVC.imageView.frame
        
        containerView.insertSubview(toVC.view, belowSubview: formVC.view)
        containerView.addSubview(snapshotView!)
        formVC.imageView.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            
            formVC.view.alpha = 0
            snapshotView?.frame = containerView.convert(toVC.selectCell!.iconImageView.frame, from: toVC.selectCell)
            
        }) { (completion) in
            
            toVC.selectCell?.iconImageView.isHidden = false
            formVC.imageView.isHidden = false
            snapshotView?.removeFromSuperview()
        
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
