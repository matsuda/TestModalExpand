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

    @IBAction func tapButton(sender: AnyObject) {
        if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("Detail") as? ListViewController {
            controller.transitioningDelegate = self
            controller.modalPresentationStyle = UIModalPresentationStyle.Custom
            controller.delegate = self

            let tableView = controller.tableView
            let index: Int = 4
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            // println("indexPath >>>>>>> \(indexPath)")
            // println("tableView >>>>>>> \(tableView)")

//            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) {
//                let frame = cell.frame
//                let offset = tableView.contentOffset
//                let y = (frame.origin.y + frame.size.height) - offset.y + UIApplication.sharedApplication().statusBarFrame.size.height
//                self.divideY = y
//            }
            self.presentViewController(controller, animated: true, completion: nil)
        }
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

