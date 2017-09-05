//
//  ExpandingViewTransitionAnimatorPresent.swift
//  firstFullApp_Weather
//
//  Created by Alexander Stevens on 9/5/17.
//  Copyright © 2017 Alex Stevens. All rights reserved.
//

import Foundation
import UIKit

class ExpandingViewTransitionAnimatorPresent: NSObject, UIViewControllerAnimatedTransitioning {
    
    fileprivate let expandableView: UIView
    fileprivate let expandViewAnimationDuration: TimeInterval
    fileprivate let presentVCAnimationDuration: TimeInterval
    
    init (expandableView: UIView,
          expandViewAnimationDuration: TimeInterval,
          presentVCAnimationDuration: TimeInterval) {
        self.expandableView = expandableView
        self.expandViewAnimationDuration = expandViewAnimationDuration
        self.presentVCAnimationDuration = presentVCAnimationDuration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.expandViewAnimationDuration + self.presentVCAnimationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let sourceVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        let destinationVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        destinationVC.modalPresentationStyle = .custom
        destinationVC.view.backgroundColor = UIColor.orange
        destinationVC.view.alpha = 0
        
        let containerView = transitionContext.containerView
        containerView.addSubview(sourceVC.view)
        containerView.addSubview(destinationVC.view)
        
        let beginZPosition = self.expandableView.layer.zPosition
        let beginTransform = self.expandableView.transform
        
        
        
        let finalTransform = calculateFinalTransformOfExpandingViewInSourceVC(self.expandableView, sourceVC: sourceVC)
        
        
        self.expandableView.layer.zPosition = CGFloat.greatestFiniteMagnitude - 1
        
        UIView.animate(withDuration: self.expandViewAnimationDuration, delay: 0, options: .transitionCrossDissolve, animations: {
            self.expandableView.transform = finalTransform
            
            UIView.animate(withDuration: self.expandViewAnimationDuration, animations: {
                self.expandableView.backgroundColor = destinationVC.view.backgroundColor
            })
            
        }, completion: { _ in
            UIView.animate(withDuration: self.presentVCAnimationDuration, animations: {
                destinationVC.view.alpha = 1
            }, completion: { _ in
                self.expandableView.transform = beginTransform
                self.expandableView.layer.zPosition = beginZPosition
                transitionContext.completeTransition(true)
                self.expandableView.backgroundColor = UIColor.black // return to original button color
            })
        })
    }
    
    fileprivate func calculateFinalTransformOfExpandingViewInSourceVC(
        _ expandingView: UIView,
        sourceVC: UIViewController) -> CGAffineTransform {
        
        // left, right, top, bottom
        let offsets = [expandingView.frame.origin.x,
                       sourceVC.view.bounds.width - expandingView.frame.origin.x,
                       expandingView.frame.origin.y,
                       sourceVC.view.bounds.height - expandingView.frame.origin.y]
        
        let minExpandingViewDim = min(expandableView.bounds.width,
                                      expandableView.bounds.height)
        
        let maxOffsetVal = offsets.max()!
        let maxSourceDim = max(sourceVC.view.bounds.width,
                               sourceVC.view.bounds.height)
        
        // to make sure that source is filled by `expandingView`
        // especially if the view has rounded edges
        let threshold_scale: CGFloat = 2
        
        let scale = (maxSourceDim + maxOffsetVal) / minExpandingViewDim + threshold_scale
        return CGAffineTransform(scaleX: scale, y: scale)
    }
}
