//
//  ListViewController.swift
//  TestModalExpand
//
//  Created by Kosuke Matsuda on 2015/06/28.
//  Copyright (c) 2015年 matsuda. All rights reserved.
//

import UIKit

@objc protocol ListViewControllerDelegate {
    func listViewController(controller: ListViewController, didSelectIndex index: Int)
}

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
    UIViewControllerTransitioningDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedIndex: Int = 0
    var delegate: ListViewControllerDelegate?

    var divideY: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail" {
            let destination = segue.destinationViewController as! DetailViewController
            destination.modalPresentationStyle = .Custom
            destination.transitioningDelegate = self
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.selectedIndex = indexPath.row
        let CellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
        }
        cell?.textLabel?.text = "Detail : \(indexPath.row)"
        return cell!
    }
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0)) {
            println("\(tableView.contentOffset)")
            println("\(cell.frame)")
        }
        self.delegate?.listViewController(self, didSelectIndex: indexPath.row)
    }
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) {
            let frame = cell.frame
            let offset = tableView.contentOffset
            let y = (frame.origin.y + frame.size.height) - offset.y + UIApplication.sharedApplication().statusBarFrame.size.height
            self.divideY = y
        }
        self.performSegueWithIdentifier("showDetail", sender: indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = SpreadAnimator(presenting: true)
        animator.divideY = self.divideY
        return animator
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = SpreadAnimator(presenting: false)
        animator.divideY = self.divideY
        return animator
    }
}
