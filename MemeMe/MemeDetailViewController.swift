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
  @IBOutlet weak var memeImage: UIImageView!
  
  override func viewWillAppear(animated: Bool) {
    viewWillAppear(true)
    memeImage.image = meme.memedImage
  }
}