//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Victor Guerra on 06/04/15.
//  Copyright (c) 2015 Victor Guerra. All rights reserved.
//

import UIKit

class MemeEditorViewController : UIViewController {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var camaraButton: UIBarButtonItem!
    @IBOutlet weak var activityButton: UIBarButtonItem!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    var memedImage: UIImage?
    var meme: Meme?
    
    var memes:[Meme]!

    // Dictionary that contains the keyboard notifications we want 
    // to subscribe to / unsubscribe from
    let keyboardNotifications = [UIKeyboardWillShowNotification : "keyboardWillShow:",
        UIKeyboardWillHideNotification: "keyboardWillHide:"]

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

        // Checking if Camera is available
        let cameraSourceType = UIImagePickerControllerSourceType.Camera
        camaraButton.enabled = UIImagePickerController.isSourceTypeAvailable(cameraSourceType)

        // Styling text fields
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0
        ]
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        // Keyboard Notifications
        subscribeToKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    @IBAction func showActivityController(sender: AnyObject) {
        memedImage = generateMemedImage()
        var activityController = UIActivityViewController(activityItems: [memedImage!],
            applicationActivities: nil)
        activityController.completionWithItemsHandler = activityControllerFinished
        
        self.presentViewController(activityController, animated: true, completion: nil)
    }
    
    func activityControllerFinished(activityType:String!, completed: Bool,
        returnedItems: [AnyObject]!, activityError: NSError!) {
            if completed {
                saveSharedMeme()
            }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveSharedMeme() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!,
            image: previewImage.image!, memedImage: memedImage!)
        (UIApplication.sharedApplication().delegate
            as! AppDelegate).memes.append(meme)
    }
    
    // MARK: Keyboard handling and notifications
    func subscribeToKeyboardNotifications() {
        for (nameNotification, selectorNotification) in keyboardNotifications {
            NSNotificationCenter.defaultCenter().addObserver(
                self, selector: Selector(selectorNotification),
                name: nameNotification, object: nil)
        }
    }
    
    func unsubscribeFromKeyboardNotifications() {
        for nameNotification in keyboardNotifications.keys {
            NSNotificationCenter.defaultCenter().removeObserver(
                self, name: nameNotification,
                object: nil)
        }
    }

    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let keyboardSize = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    // MARK: Picking Image from Camara and Albums
    
    @IBAction func pickImageFromCamara(sender: UIBarButtonItem) {
        presentImagePickerWithSource(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBAction func pickImageFromAlbum(sender: UIBarButtonItem) {
        presentImagePickerWithSource(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    /// Showing an ImagePicker given a Source Type.
    func presentImagePickerWithSource(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self
        imagePickerView.sourceType = sourceType
        self.presentViewController(imagePickerView, animated: true, completion: nil)
    }
    
    // Generate MemedImage
    func generateMemedImage() -> UIImage {
        topToolBar.hidden = true
        bottomToolbar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topToolBar.hidden = false
        bottomToolbar.hidden = false
        return memedImage
    }
    
}

// MARK: conforming to UIImagePickerControllerDelegate protocol

extension MemeEditorViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            previewImage.image = image
            // Now we enable the Activity button
            activityButton.enabled = true
            picker.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

// MARK: conforming to UITextField Delegate protocol
extension MemeEditorViewController : UITextFieldDelegate {

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }

}
