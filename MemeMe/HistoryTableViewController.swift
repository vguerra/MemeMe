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
  var needToShowEditor: Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addShowEditorButton()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    fetchMemesFromAppDelegate()
    sentMemesTableView.reloadData()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    // When the view appears for the 1st time no Memes
    // so we show automatically the editor
    if needToShowEditor {
      showMemeEditor(false)
      needToShowEditor = false
    }
  }
  
  // MARK: Conforming to UITableViewDataSource protocol
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return memes!.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let memeCell = tableView.dequeueReusableCellWithIdentifier("memeTableCell", forIndexPath: indexPath) as! MemeTableViewCell
    let meme = memes![indexPath.row]
    memeCell.memeLabel.text = meme.topText + " ... " + meme.bottomText
    memeCell.memeImage.image = meme.memedImage
    return memeCell
  }
  
  // MARK: Conforming to UITableViewDelegate protocol
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    detailViewController.meme = memes[indexPath.row]
    
    self.navigationController!.pushViewController(detailViewController, animated: true)
  }
}