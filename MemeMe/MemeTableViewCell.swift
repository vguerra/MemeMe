//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Victor Guerra on 12/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

/// A simple View Cell that encapsulates a Label that combines 
/// bottom and top text and the Memed Image used in Table View
class MemeTableViewCell : UITableViewCell {
    
    @IBOutlet weak var memeLabel: UILabel!
    @IBOutlet weak var memeImage: UIImageView!
}