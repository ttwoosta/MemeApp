//
//  TMMemeDetailVC.swift
//  MemeApp
//
//  Created by Tu Tong on 7/13/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

class TMMemeDetailVC: UIViewController {
    
    var meme: TMMeme!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = meme.topText
        self.imgView.image = meme.memeImage
    }
    
}
