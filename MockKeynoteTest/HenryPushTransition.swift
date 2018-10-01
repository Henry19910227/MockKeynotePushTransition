//
//  HenryPushTransition.swift
//  MockKeynoteTest
//
//  Created by 廖冠翰 on 2018/9/30.
//  Copyright © 2018年 廖冠翰. All rights reserved.
//

import UIKit

class HenryPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from) as! OneViewController
        
        let toVC = transitionContext.viewController(forKey: .to) as! TwoViewController
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0
        
        let containerView = transitionContext.containerView //容器
        
        //獲取動畫過度圖片
        let snapshotView = fromVC.selectCell?.iconImageView.snapshotView(afterScreenUpdates: false)
        snapshotView!.frame = containerView.convert(fromVC.selectCell!.iconImageView.frame, from: fromVC.selectCell)
        fromVC.selectCell?.iconImageView.isHidden = true
        
        //添加
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshotView!)
        
        //強制更新一次toVC subview的大小
        toVC.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            
            toVC.view.alpha = 1
            snapshotView?.frame = toVC.imageView.frame
            
        }) { (completion) in
            
            toVC.imageView.image = fromVC.selectCell?.iconImageView.image
            snapshotView?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
