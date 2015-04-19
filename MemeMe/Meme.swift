//
//  Meme.swift
//  MemeMe
//
//  Created by Victor Guerra on 10/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

/// Meme objects contain all information necesary for
/// creating a Meme image
/// Its members are all constants
struct Meme {
    /// Top text of image
    let topText: String
    let bottomText: String
    let image: UIImage
    let memedImage: UIImage
    
    init (topText: String, bottomText: String,
        image: UIImage, memedImage: UIImage) {
            self.topText = topText
            self.bottomText = bottomText
            self.image = image
            self.memedImage = memedImage
    }
}