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
    var delegate: ListViewControllerDelegate?
    var dataSource: [String] = [String]()

    var divideY: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.tableFooterView = UIView()
        for i in 0..<5 {
            self.dataSource.append("Detail : \(i)")
        }
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
            destination.transitioningDelegate = self
            destination.modalPresentationStyle = .Custom
        }
    }

    @IBAction func tapClose(sender: AnyObject) {
        self.delegate?.listViewController(self, didSelectIndex: 3)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
        }
        cell?.textLabel?.text = self.dataSource[indexPath.row]
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
//            let y = (frame.origin.y + frame.size.height) - offset.y + UIApplication.sharedApplication().statusBarFrame.size.height
            let y = (frame.origin.y + frame.size.height) - offset.y //+ self.topLayoutGuide.length
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
