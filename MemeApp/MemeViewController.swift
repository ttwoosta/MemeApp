//
//  MemeViewController.swift
//  MemeApp
//
//  Created by Tu Tong on 7/11/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    
    var meme: TMMeme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imageView.image = self.meme.memeImage
    }
    
}
