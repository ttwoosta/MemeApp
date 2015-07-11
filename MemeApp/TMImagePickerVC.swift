//
//  TMImagePickerVC.swift
//  MemeApp
//
//  Created by Tu Tong on 7/10/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

class TMImagePickerVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var barBtnItemPickImageCamera: UIBarButtonItem!
    
    //////////////////////////////////
    // Override view controller funcs
    //////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // textFields default attributes
        let mmTextAttributes = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: 1.0,
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
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "keyboardWillHide:",
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
    
    //////////////////////////////////
    // UIImagePickerControllerDelegate
    //////////////////////////////////
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.imgView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

