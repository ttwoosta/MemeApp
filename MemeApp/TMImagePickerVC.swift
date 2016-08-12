//
//  TMImagePickerVC.swift
//  MemeApp
//
//  Created by Tu Tong on 7/10/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

class TMImagePickerVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    

    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!

    // nanvigation bar items
    @IBOutlet weak var barItemCancel: UIBarButtonItem!
    @IBOutlet weak var barItemShare: UIBarButtonItem!
    
    // Bottom bar and camera item
    @IBOutlet weak var bottomBar: UIToolbar!
    @IBOutlet weak var barBtnItemPickImageCamera: UIBarButtonItem!
    
    
    //////////////////////////////////
    // Override view controller funcs
    //////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // disable navigation items and hides textFields
        self.hasMemeImage = false
        
        // textFields default attributes
        let mmTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -3.0,
        ]
        self.textFieldTop.defaultTextAttributes = mmTextAttributes
        self.textFieldBottom.defaultTextAttributes = mmTextAttributes
        
        // Text aligment center
        self.textFieldTop.textAlignment = NSTextAlignment.Center
        self.textFieldBottom.textAlignment = NSTextAlignment.Center
        
        // textFields delegate
        self.textFieldTop.delegate = self
        self.textFieldBottom.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Enable/disable bar button item
        // according to source type available
        self.barBtnItemPickImageCamera.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // subcribe to keyboard notification
        self.subcribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // unsubcribe from keyboard notification
        self.unsubcribeFromKeyboardNotification()
    }
    
    /////////////////////
    // UITextFieldDelegate
    /////////////////////
    
    // clear default text on textFields
    func textFieldDidBeginEditing(textField: UITextField) {
        if (textField.text == "TOP" && textField == textFieldTop) ||
            (textField.text == "BOTTOM" && textField == textFieldBottom) {
            textField.text = ""
        }
    }
    
    // dimiss keyboard when tap on return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /////////////////////
    // Keyboard notifications
    /////////////////////
    
    func subcribeToKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: #selector(TMImagePickerVC.keyboardWillShow(_:)),
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: #selector(TMImagePickerVC.keyboardWillHide(_:)),
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    func unsubcribeFromKeyboardNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillShowNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    /////////////////////
    // Handle keyboard appear/disappear
    /////////////////////
    
    // when keyboardWillShow notification is recieved, shift view frame up
    func keyboardWillShow(notification: NSNotification) {
        if self.textFieldBottom.isFirstResponder() {
            self.view.frame.origin.y -= self.getKeyboardHeight(notification)
        }
    }
    
    // when keyboardWillHide notification is recieved, shift view frame down
    func keyboardWillHide(notification: NSNotification) {
        if self.textFieldBottom.isFirstResponder() {
            self.view.frame.origin.y += self.getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    //////////////////////////////////
    // Button event handlers
    //////////////////////////////////
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imgPicker.delegate = self
        self.presentViewController(imgPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func pickImageFromCamera(sender: AnyObject) {
        
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = UIImagePickerControllerSourceType.Camera
        imgPicker.delegate = self
        self.presentViewController(imgPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //////////////////////////////////
    // UIImagePickerControllerDelegate
    //////////////////////////////////
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        // set image to imageView
        self.imgView.image = image
        
        // enable navigation items and show textFields
        self.hasMemeImage = true
        
        // reorder controls so that textFields
        // would stay on top of imageView
        self.centerView.sendSubviewToBack(imgView)
        // bring toolbar to front
        self.view.bringSubviewToFront(self.bottomBar)
        
        // hide image picker
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /////////////////////
    // Activity sheet
    /////////////////////
    
    @IBAction func activityAction(sender: AnyObject) {
        
        // generate meme image
        let memeImage = generateMemeImage()
        
        let activityVC = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            if completed {
                
                // initialize meme object
                let meme = TMMeme(orgImage: self.imgView.image!,
                    memeImage: memeImage,
                    topText: self.textFieldTop.text,
                    bottomText: self.textFieldBottom.text)
                
                // save meme object
                let appDelegate = AppDelegate.sharedAppDelegate()
                appDelegate.sharedMemes.append(meme)
                
                // hide image picker
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            else if let error = error {
                let alert = UIAlertView(title: error.localizedFailureReason,
                    message: error.localizedDescription,
                    delegate: nil,
                    cancelButtonTitle: "OK")
                alert.show()
            }
        }
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    ////////////////////////////////
    // Generate Meme image
    // Render venter view to an image
    /////////////////////////////////

    func generateMemeImage() -> UIImage {
        
        // hide textFields if needed
        textFieldTop.hidden = (textFieldTop.text == "TOP")
        textFieldBottom.hidden = (textFieldBottom.text == "BOTTOM")
        
        // image dimension
        let imageRect = self.centerView.bounds
        
        // begin image context
        UIGraphicsBeginImageContext(imageRect.size)
        
        // render view hierarchy
        self.centerView.drawViewHierarchyInRect(imageRect, afterScreenUpdates: true)
        
        // grabe image from current context
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // end image context
        UIGraphicsEndImageContext()
        
        // show textFields
        textFieldTop.hidden = false
        textFieldBottom.hidden = false
        
        return memeImage
    }
    
    /////////////////////
    // Meme State
    /////////////////////
    
    var hasMemeImage: Bool = false {
        didSet {
            self.barItemShare.enabled = self.hasMemeImage
            self.textFieldTop.hidden = !self.hasMemeImage
            self.textFieldBottom.hidden = !self.hasMemeImage
        }
    }
}

