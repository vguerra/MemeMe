//
//  HistoryTableViewController.swift
//  MemeMe
//
//  Created by Victor Guerra on 09/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class HistoryTableViewController : UITableViewController {
    var memes : [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self, action: "showMemeEditor")
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        memes = appDelegate.memes
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let memesCount = memes?.count {
            return memesCount
        }
        return 0
    }
    
    func showMemeEditor() {
        let memeEditorController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(memeEditorController, animated: true, completion: nil)
    }
}