//
//  HistoryTableViewController.swift
//  MemeMe
//
//  Created by Victor Guerra on 09/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class HistoryTableViewController : HistoryGeneralController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var sentMemesTableView: UITableView!
    @IBOutlet weak var editTableButton: UIBarButtonItem!
    
    // MARK: Life cycle
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchMemesFromAppDelegate()
        sentMemesTableView.reloadData()
        editTableButton.enabled = memes.count > 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // When the view appears for the 1st time no Memes
        // so we show automatically the editor
        if memes.count == 0 {
            showModalMemeEditor(true)
        }
    }
    
    // MARK: IB Actions
    @IBAction func toggleTableEditMode(sender: UIBarButtonItem) {
        if sentMemesTableView.editing {
            editTableButton.title = "Edit"
        } else {
            editTableButton.title = "Done"
        }
        sentMemesTableView.setEditing(!sentMemesTableView.editing, animated: true)
    }
    
    @IBAction func showMemeEditor(sender: UIBarButtonItem) {
        showModalMemeEditor(true)
    }
    
    // MARK: Conforming to UITableViewDataSource protocol
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let memeCell = tableView.dequeueReusableCellWithIdentifier("memeTableCell", forIndexPath: indexPath) as! MemeTableViewCell
        let meme = memes![indexPath.row]
        memeCell.memeLabel.text = meme.topText! + " ... " + meme.bottomText!
        memeCell.memeImage.image = meme.memedImage!
        return memeCell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteMemeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    // MARK: Conforming to UITableViewDelegate protocol
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showDetailControllerWithMemeAt(indexPath.row)
    }
}