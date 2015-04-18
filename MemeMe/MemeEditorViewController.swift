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
  
  // MARK: View life cycle
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
    
    // In case we come from the Detail Scene
    if let memeValue = meme {
      topTextField.text = memeValue.topText
      bottomTextField.text = memeValue.bottomText
      previewImage.image = memeValue.image
      setUIElementsEnabled(true)
    } else if previewImage.image == nil {
      // Disabling some elements that should be enabled
      // when we choose an image
      setUIElementsEnabled(false)
    } else {
      setUIElementsEnabled(true)
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(true)
    unsubscribeFromKeyboardNotifications()
  }

  // MARK: View controller config
  override func prefersStatusBarHidden() -> Bool {
    return true
  }

  // MARK: IB Actions
  @IBAction func showActivityController(sender: AnyObject) {
    memedImage = generateMemedImage()
    var activityController = UIActivityViewController(activityItems: [memedImage!],
      applicationActivities: nil)
    activityController.completionWithItemsHandler = activityControllerFinished
    
    self.presentViewController(activityController, animated: true, completion: nil)
  }

  @IBAction func cancel(sender: AnyObject) {
    dismissMemeEditor()
  }

  @IBAction func pickImageFromCamara(sender: UIBarButtonItem) {
    presentImagePickerWithSource(UIImagePickerControllerSourceType.Camera)
  }
  
  @IBAction func pickImageFromAlbum(sender: UIBarButtonItem) {
    presentImagePickerWithSource(UIImagePickerControllerSourceType.PhotoLibrary)
  }
  
  // MARK: Utilities

  func setUIElementsEnabled(state: Bool) {
    activityButton.enabled = state
    topTextField.enabled = state
    bottomTextField.enabled = state
  }
  
  func activityControllerFinished(activityType:String!, completed: Bool,
    returnedItems: [AnyObject]!, activityError: NSError!) {
      if completed {
        saveSharedMeme()
        dismissMemeEditor()
      }
  }
  
  func dismissMemeEditor() {
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
  
  // MARK: Picking Image from Camera and Albums
  
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
        picker.dismissViewControllerAnimated(true, completion: nil)
      }
  }
}

// MARK: conforming to UITextField Delegate protocol
extension MemeEditorViewController : UITextFieldDelegate {
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    if textField.text == "TOP" || textField.text == "BOTTOM" {
      textField.text = ""
    }
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
  
  // Eventhough we specify capitalization for all chars
  // we do it here in case the laptop keyboard is used when 
  // runnng the simulator
  func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    if string.isEmpty {
      return true
    }
    textField.text = textField.text + string.uppercaseString
    return false
  }
}
