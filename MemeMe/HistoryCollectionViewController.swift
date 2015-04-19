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
  @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
  // MARK: View life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Adjusting the size of each cell acording to the
    // collectionView dimensions and screen orientation
    let minSpace = CGFloat(2.0)
    var width:CGFloat
    if (UIApplication.sharedApplication().statusBarOrientation == .Portrait) {
      width = CGRectGetWidth(memeCollectionView!.frame)
    } else {
      width = CGRectGetHeight(memeCollectionView!.frame)
    }
    width = (width - 2*minSpace)/3
    flowLayout.itemSize = CGSize(width: width, height: width)
    flowLayout.minimumInteritemSpacing = minSpace
    flowLayout.minimumLineSpacing = minSpace
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    fetchMemesFromAppDelegate()
    memeCollectionView.reloadData()


  
  }
  
  // MARK: IB Actions
  @IBAction func showMemeEditor(sender: UIBarButtonItem) {
    showModalMemeEditor(true)
  }

  // MARK: Conforming to the UICollectionViewDataSource protocol
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return memes.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let memeCell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
    let meme = memes[indexPath.row]
    memeCell.memeImage.image = meme.memedImage
    return memeCell
  }
  
  // MARK: Conforming to the UICollectionViewDelegate protocol
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    showDetailControllerWithMemeAt(indexPath.row)
  }
}