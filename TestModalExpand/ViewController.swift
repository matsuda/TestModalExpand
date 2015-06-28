//
//  ViewController.swift
//  TestModalExpand
//
//  Created by Kosuke Matsuda on 2015/06/28.
//  Copyright (c) 2015年 matsuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate, ListViewControllerDelegate {

    var divideY: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showList" {
            if let destination = segue.destinationViewController as? UINavigationController {
                destination.transitioningDelegate = self
                destination.modalPresentationStyle = .Custom
                let controller = destination.viewControllers.first as! ListViewController
                controller.delegate = self
            }
        }
    }

    @IBAction func tapButton(sender: AnyObject) {
        self.performSegueWithIdentifier("showList", sender: self)
    }

    func listViewController(controller: ListViewController, didSelectIndex index: Int) {
        let tableView = controller.tableView
        if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) {
            let frame = cell.frame
            let offset = tableView.contentOffset
            let y = (frame.origin.y + frame.size.height) - offset.y + UIApplication.sharedApplication().statusBarFrame.size.height
            self.divideY = y
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ShutAnimator(presenting: true)
        return animator
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = ShutAnimator(presenting: false)
        animator.divideY = self.divideY
        return animator
    }
}

