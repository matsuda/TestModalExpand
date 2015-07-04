//
//  DetailViewController.swift
//  TestModalExpand
//
//  Created by Kosuke Matsuda on 2015/06/28.
//  Copyright (c) 2015年 matsuda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let row = 4
        let c = row % 3
        let r = abs(row * 10 - 255)
        switch c {
        case 0:
            self.view.backgroundColor = UIColor(red: CGFloat(r)/255.0, green: 120/255.0, blue: 80/255.0, alpha: 1)
        case 1:
            self.view.backgroundColor = UIColor(red: 120/255, green: CGFloat(r)/255, blue: 80/255, alpha: 1)
        case 2:
            self.view.backgroundColor = UIColor(red: 80/255, green: 120/255, blue: CGFloat(r)/255, alpha: 1)
        default:
            break
        }
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width - 20, height: 100))
        label.text = "Detail : \(row)"
        self.view.addSubview(label)
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

    @IBAction func tapButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
