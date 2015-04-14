//
//  HistoryCollectionViewController.swift
//  MemeMe
//
//  Created by Victor Guerra on 09/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class HistoryCollectionViewController : HistoryGeneralController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  @IBOutlet var memeCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addShowEditorButton()
    
    let width = CGRectGetWidth(memeCollectionView!.frame)/3
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: width, height: width)
    memeCollectionView.collectionViewLayout = flowLayout
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    fetchMemesFromAppDelegate()
    memeCollectionView.reloadData()
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let memeCell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
    let meme = memes[indexPath.row]
    memeCell.memeImage.image = meme.memedImage
    return memeCell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    detailViewController.meme = memes[indexPath.row]
    
    self.navigationController!.pushViewController(detailViewController, animated: true)
  }
  
}