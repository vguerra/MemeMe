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

struct Meme {
    /// Top text of image
    var topText: String?
    /// Bottom text of the Image
    var bottomText: String?
    /// Original Image the meme is generated from
    var image: UIImage?
    /// The result meme Image
    var memedImage: UIImage?

    /// Initializes a Meme object with all its memebers
    init (topText: String, bottomText: String,
        image: UIImage, memedImage: UIImage) {
            self.topText = topText
            self.bottomText = bottomText
            self.image = image
            self.memedImage = memedImage
    }
}