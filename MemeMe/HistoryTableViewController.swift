//
//  HistoryTableViewController.swift
//  MemeMe
//
//  Created by Victor Guerra on 09/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class HistoryTableViewController : UITableViewController {
    var memes : [Int]?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if memes == nil {
            showMemeEditor()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let memesCount = memes?.count {
        }
        return 0
    }
    
    func showMemeEditor() {
        let memeEditorController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.navigationController?.pushViewController(memeEditorController, animated: true)
    
    }
}