//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Victor Guerra on 10/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class MemeDetailViewController : UIViewController {
  var meme : Meme!
  var memeIndex : Int!
  let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
  
  @IBOutlet weak var memeImage: UIImageView!
  
  // MARK: View life cycle
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(false)
    memeImage.image = meme.memedImage
  }
  
  // MARK: Actions
  @IBAction func deleteMeme(sender: AnyObject) {
    weak var wself: MemeDetailViewController? = self
    
    let alertController = UIAlertController(title: "Delete this Meme?", message: "Sure?", preferredStyle: .Alert)
    
    let cancelAction = UIAlertAction(title: "No", style: .Cancel, handler: nil)
    alertController.addAction(cancelAction)

    let confirmAction = UIAlertAction(title: "Yes, delete!", style: .Default) { _  in
      if let sself = wself {
        sself.appDelegate.memes.removeAtIndex(sself.memeIndex)
        sself.navigationController?.popViewControllerAnimated(true)
      }
    }

    alertController.addAction(confirmAction)
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  // MARK: View configuration
  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  
  
}