//
//  MaskTransition.swift
//  Eva
//
//  Created by Camilo Vera Bezmalinovic on 3/6/16.
//  Copyright © 2016 Axiom Zen. All rights reserved.
//

import UIKit

internal class MaskTransition: NSObject {
    let presenting: Bool
    let position: CGPoint
    init(presenting: Bool, position: CGPoint) {
        self.presenting = presenting
        self.position = position
    }
}

extension MaskTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.2
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            container = transitionContext.containerView() else {
                transitionContext.completeTransition(false)
                return
        }
        
        let view = presenting ? toVC.view : fromVC.view
        container.addSubview(view)
        
        let bounds = container.bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let smallRect = CGRect(x: position.x - 0.5, y: position.y - 0.5, width: 1, height: 1)
        let diameter = sqrt(pow(bounds.width, 2) + pow(bounds.height, 2))
        let bigRect = CGRect(x: center.x - diameter/2, y: center.y - diameter/2, width: diameter, height: diameter)
        let smallPath = UIBezierPath(ovalInRect: smallRect).CGPath
        let bigPath = UIBezierPath(ovalInRect: bigRect).CGPath
        
        let mask = CAShapeLayer()
        mask.frame = bounds
        mask.path = presenting ? bigPath : smallPath
        mask.fillColor = UIColor.blackColor().CGColor
        view.layer.mask = mask
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            transitionContext.completeTransition(true)
            view.layer.mask = nil
            if !self.presenting {
                fromVC.view.removeFromSuperview()
            }
        }
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = presenting ? smallPath : bigPath
        animation.toValue = presenting ? bigPath : smallPath
        animation.duration = transitionDuration(transitionContext)
        mask.addAnimation(animation, forKey: "path")
        CATransaction.commit()
    }
}
