//
//  HistoryCollectionViewController.swift
//  MemeMe
//
//  Created by Victor Guerra on 09/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class HistoryCollectionViewController : UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "showMemeEditor")
    }

}