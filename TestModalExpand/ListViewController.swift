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

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedIndex: Int = 0
    var delegate: ListViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: indexPath.row, inSection: 0)) {
            println("\(tableView.contentOffset)")
            println("\(cell.frame)")
        }
        self.delegate?.listViewController(self, didSelectIndex: indexPath.row)
    }
}
