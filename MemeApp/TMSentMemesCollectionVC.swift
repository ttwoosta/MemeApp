//
//  TMSentMemesCollectionVC.swift
//  MemeApp
//
//  Created by Tu Tong on 7/12/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

class TMSentMemesCollectionVC: UICollectionViewController {
    
    var sharedMemes: [TMMeme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.sharedMemes = AppDelegate.sharedAppDelegate().sharedMemes
        self.collectionView?.reloadData()
    }
    
    /////////////////////
    // UICollectionViewDataSource
    /////////////////////
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sharedMemes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TMMemeCollectionViewCell
        let meme = self.sharedMemes[indexPath.row]
        
        cell.imgView.image = meme.memeImage
        cell.lblTitle.text = meme.topText
        cell.lblSubtitle.text = meme.bottomText
        
        return cell
    }
    
    /////////////////////
    // UICollectionViewDelegate
    /////////////////////
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let meme = sharedMemes[indexPath.row] as TMMeme
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("TMMemeDetailVC") as! TMMemeDetailVC
        vc.meme = meme
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
