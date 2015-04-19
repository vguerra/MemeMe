//
//  HistoryGeneralController.swift
//  MemeMe
//
//  Created by Victor Guerra on 12/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

/// HistoryGeneralController encapsulates general functionality
/// needed for all other ViewControllers.

class HistoryGeneralController : UIViewController {
    
    /// Array of memes that is used as Data Model for Table view and 
    /// Collection view
    var memes : [Meme]!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    /// populates the memes array with all information stored in the application
    /// delegate
    func fetchMemesFromAppDelegate() {
        memes = appDelegate.memes
    }
    
    /// Deletes a meme given an index
    func deleteMemeAtIndex(index: Int) {
        appDelegate.memes.removeAtIndex(index)
        fetchMemesFromAppDelegate()
    }
    
    /// Shows the Meme Editor in Modal mode.
    func showModalMemeEditor(animated: Bool, withMeMeAtIndex: Int? = nil) {
        let memeEditorController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        if let index = withMeMeAtIndex {
            memeEditorController.meme = memes![index]
            memeEditorController.memeIndex = index
        }
        
        self.presentViewController(memeEditorController, animated: animated, completion: nil)
    }
    
    /// Showing the Detail scene 
    func showDetailControllerWithMemeAt(index: Int) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        detailViewController.memeIndex = index
        detailViewController.hidesBottomBarWhenPushed = true
        
        self.navigationController!.pushViewController(detailViewController, animated: true)
        
    }
}
