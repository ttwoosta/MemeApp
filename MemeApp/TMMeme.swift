//
//  TMMeme.swift
//  MemeApp
//
//  Created by Tu Tong on 7/11/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit


struct TMMeme {
    var topText: String!
    var bottomText: String!
    var orgImage: UIImage!
    var memeImage: UIImage!
    
    init(orgImage: UIImage, memeImage: UIImage, topText: String!, bottomText: String!) {
        self.orgImage = orgImage
        self.memeImage = memeImage
        self.topText = topText
        self.bottomText = bottomText
    }
    
}