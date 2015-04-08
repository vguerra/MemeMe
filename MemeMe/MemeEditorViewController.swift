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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

        // Checking if Camera is available
        camaraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)

        // Styling text fields
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        // Keyboard Notifications
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Keyboard handling and notifications
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }

    func keyboardWillShow() {
    }
    
    // MARK: Picking Image from Camara and Albums
    
    @IBAction func pickImageFromCamara(sender: UIBarButtonItem) {
        presentImagePicker(UIImagePickerControllerSourceType.Camera)
    }
    
    @IBAction func pickImageFromAlbum(sender: UIBarButtonItem) {
        presentImagePicker(UIImagePickerControllerSourceType.PhotoLibrary)
    }
    
    /// Showing an ImagePicker given a Source Type.
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self
        imagePickerView.sourceType = sourceType
        self.presentViewController(imagePickerView, animated: true, completion: nil)
    }

    
}

// MARK: conforming to UIImagePickerControllerDelegate protocol

extension MemeEditorViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            previewImage.image = image
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
