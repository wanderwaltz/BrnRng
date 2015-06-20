//
//  HomeViewController.swift
//  BrnRng
//
//  Created by Tatyana Lomonosova on 7/14/14.
//  Copyright (c) 2014 Tanchey. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "rid")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let row = self.tableView.indexPathForSelectedRow() {
            self.tableView.deselectRowAtIndexPath(row, animated: animated)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("rid") as! UITableViewCell
        cell.textLabel?.text = "Set #\(indexPath.row)"
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        println(indexPath)
        self.performSegueWithIdentifier("showquestions", sender:indexPath)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let indexPath = sender as? NSIndexPath {
            println(indexPath)
            let qvc = segue.destinationViewController as! QuestionViewController
            qvc.baseNumber = indexPath.row
        }
    }
}

