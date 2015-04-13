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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addShowEditorButton()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    fetchMemesFromAppDelegate()
    sentMemesTableView.reloadData()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes!.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let memeCell = tableView.dequeueReusableCellWithIdentifier("memeTableCell") as! MemeTableViewCell
    let meme = memes![indexPath.row]
    memeCell.memeLabel.text = meme.topText + meme.bottomText
    memeCell.memeImage.image = meme.memedImage
    return memeCell
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    detailViewController.meme = memes[indexPath.row]
    
    self.navigationController!.pushViewController(detailViewController, animated: true)
  }
}