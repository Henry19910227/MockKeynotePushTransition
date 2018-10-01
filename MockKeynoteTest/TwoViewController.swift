//
//  TwoViewController.swift
//  MockKeynoteTest
//
//  Created by 廖冠翰 on 2018/9/30.
//  Copyright © 2018年 廖冠翰. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var percentDrivenTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestureRecognizer(gestureRecognizer:)))
        panGesture.edges = .left
        view.addGestureRecognizer(panGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.delegate = self
    }
}

//MARK: - UINavigationControllerDelegate
extension TwoViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return operation == .pop ? HenryPopTransition() : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return percentDrivenTransition
    }
}

//MARK: - Event Handler
extension TwoViewController {
    
    @objc private func edgePanGestureRecognizer(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        let progress = gestureRecognizer.translation(in: view).x / view.bounds.size.width
        
        if gestureRecognizer.state == .began {
            print("開始滑動!")
            percentDrivenTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewController(animated: true)
            
        }else if (gestureRecognizer.state == .changed) {
            
            if progress > 0 {
                percentDrivenTransition!.update(progress)
            }
            
        }else if (gestureRecognizer.state == .cancelled || gestureRecognizer.state == .ended) {
            
            if progress > 0.5{
                percentDrivenTransition!.finish()
            }else {
                percentDrivenTransition!.cancel()
            }
            percentDrivenTransition = nil
        }
        
    }
}
