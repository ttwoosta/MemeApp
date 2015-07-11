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

