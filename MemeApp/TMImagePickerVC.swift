//
//  TMImagePickerVC.swift
//  MemeApp
//
//  Created by Tu Tong on 7/10/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

class TMImagePickerVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
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
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.imgView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

