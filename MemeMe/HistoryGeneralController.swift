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
  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  func fetchMemesFromAppDelegate() {
    memes = appDelegate.memes
  }
  
  func deleteMemeAtIndex(index: Int) {
      appDelegate.memes.removeAtIndex(index)
      fetchMemesFromAppDelegate()
  }
  
  func showModalMemeEditor(animated: Bool) {
    let memeEditorController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
    self.presentViewController(memeEditorController, animated: animated, completion: nil)
  }
  
  func showDetailControllerWithMemeAt(index: Int) {
    let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    detailViewController.meme = memes[index]
    detailViewController.memeIndex = index
    
    detailViewController.hidesBottomBarWhenPushed = true
    
    self.navigationController!.pushViewController(detailViewController, animated: true)

  }
}
