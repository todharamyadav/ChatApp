//
//  ViewController.swift
//  Chat
//
//  Created by Dharamvir on 8/11/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit

class FriendViewController: UICollectionViewController {

    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //collectionView?.registerClass(FriendCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
        
        setUpData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count{
            return count
        }
        
        return 0
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath) as! FriendCell
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width/2
        cell.profileImageView.layer.masksToBounds = true
        cell.readReceiptImageView.layer.cornerRadius = cell.readReceiptImageView.frame.size.width/2
        cell.readReceiptImageView.layer.masksToBounds = true
        
        if let message = messages?[indexPath.item]{
            cell.message = message
            
        }
        
        return cell
        
    }
    
    
    

}

