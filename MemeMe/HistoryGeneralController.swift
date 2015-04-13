//
//  HistoryGeneralController.swift
//  MemeMe
//
//  Created by Victor Guerra on 12/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class HistoryGeneralController : UIViewController {
  var memes : [Meme]!
  
  func addShowEditorButton() {
    let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
      target: self, action: "showMemeEditor")
    self.navigationItem.rightBarButtonItem = addButton
  }
  
  func fetchMemesFromAppDelegate() {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    memes = appDelegate.memes
  }
  
  func showMemeEditor() {
    let memeEditorController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
    self.presentViewController(memeEditorController, animated: true, completion: nil)
  }
  
}
