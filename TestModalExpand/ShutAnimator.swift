//
//  ShutAnimator.swift
//  TestModalExpand
//
//  Created by Kosuke Matsuda on 2015/06/28.
//  Copyright (c) 2015年 matsuda. All rights reserved.
//

import UIKit

class ShutAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var presenting: Bool = false
    var divideY: CGFloat = 0

    init(presenting: Bool) {
        self.presenting = presenting
        super.init()
    }

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        if self.presenting {
            return 0.4
        } else {
            return 0.4
        }
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if self.presenting {
            self.animatePresentation(transitionContext)
        } else {
            self.animateDismissal(transitionContext)
        }
    }

    func animatePresentation(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromView = fromVC.view
        let toView = toVC.view
        let containerView = transitionContext.containerView()

        let snapshot = toView.snapshotViewAfterScreenUpdates(true)

        var w: CGFloat = CGRectGetWidth(snapshot.frame)
//        var h: CGFloat = CGRectGetHeight(snapshot.frame) / 2
        var h: CGFloat = CGRectGetHeight(snapshot.frame)

//        let topView = snapshot.resizableSnapshotViewFromRect(CGRect(x: 0, y: 0, width: w, height: h), afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
//        let bottomView = snapshot.resizableSnapshotViewFromRect(CGRect(x: 0, y: h, width: w, height: h), afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        let topView = snapshot.resizableSnapshotViewFromRect(CGRect(x: 0, y: 0, width: w, height: self.divideY), afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        let bottomView = snapshot.resizableSnapshotViewFromRect(CGRect(x: 0, y: self.divideY, width: w, height: h - self.divideY), afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)

        var topFrame = topView.frame
        var topOutFrame = CGRectOffset(topFrame, 0, -CGRectGetHeight(topFrame))

        var bottomFrame = CGRectOffset(bottomView.frame, 0, CGRectGetHeight(topFrame))
        var bottomOutFrame = CGRectOffset(bottomFrame, 0, CGRectGetHeight(bottomFrame))
        topView.frame = topOutFrame
        bottomView.frame = bottomOutFrame

        containerView.addSubview(topView)
        containerView.addSubview(bottomView)
        /*
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            topView.frame = topFrame
            bottomView.frame = bottomFrame
        }) { (finished: Bool) -> Void in
            containerView.insertSubview(toView, belowSubview: topView)
            topView.removeFromSuperview()
            bottomView.removeFromSuperview()
            let completed = !transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(completed)
        }
        */
//        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: { () -> Void in
//            topView.frame = topFrame
//            bottomView.frame = bottomFrame
//        }) { (finished: Bool) -> Void in
//            containerView.insertSubview(toView, belowSubview: topView)
//            topView.removeFromSuperview()
//            bottomView.removeFromSuperview()
//            let completed = !transitionContext.transitionWasCancelled()
//            transitionContext.completeTransition(completed)
//        }

        let duration = self.transitionDuration(transitionContext)
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            topView.frame = topFrame
        }) { (finished: Bool) -> Void in
            UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                bottomView.frame = bottomFrame
                }) { (finished: Bool) -> Void in
                    containerView.insertSubview(toView, belowSubview: topView)
                    topView.removeFromSuperview()
                    bottomView.removeFromSuperview()
                    let completed = !transitionContext.transitionWasCancelled()
                    transitionContext.completeTransition(completed)
            }
        }
    }

    func animateDismissal(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let fromView = fromVC.view
        let toView = toVC.view
        let containerView = transitionContext.containerView()

        let snapshot = fromView.snapshotViewAfterScreenUpdates(false)

        var w: CGFloat = CGRectGetWidth(snapshot.frame)
        var h: CGFloat = CGRectGetHeight(snapshot.frame)
        // println("divideY >>> \(self.divideY)")

        let topView = snapshot.resizableSnapshotViewFromRect(CGRect(x: 0, y: 0, width: w, height: self.divideY), afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)
        let bottomView = snapshot.resizableSnapshotViewFromRect(CGRect(x: 0, y: self.divideY, width: w, height: h - self.divideY), afterScreenUpdates: false, withCapInsets: UIEdgeInsetsZero)

        var topFrame = topView.frame
        var topOutFrame = CGRectOffset(topFrame, 0, -CGRectGetHeight(topFrame))

        var bottomFrame = CGRectOffset(bottomView.frame, 0, CGRectGetHeight(topFrame))
        var bottomOutFrame = CGRectOffset(bottomFrame, 0, CGRectGetHeight(bottomFrame))
        bottomView.frame = bottomFrame

        containerView.addSubview(topView)
        containerView.addSubview(bottomView)
        fromView.removeFromSuperview()
        /*
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, options: .CurveEaseOut, animations: { () -> Void in
            topView.frame = topOutFrame
            bottomView.frame = bottomOutFrame
        }) { (finished: Bool) -> Void in
            let completed = !transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(completed)
        }
        */
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { () -> Void in
            topView.frame = topOutFrame
            bottomView.frame = bottomOutFrame
        }) { (finished: Bool) -> Void in
            let completed = !transitionContext.transitionWasCancelled()
            transitionContext.completeTransition(completed)
        }
    }
}
