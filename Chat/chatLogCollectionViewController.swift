//
//  chatLogCollectionViewController.swift
//  Chat
//
//  Created by Dharamvir on 8/15/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class chatLogCollectionViewController: UICollectionViewController {
    
    var friend: Friend?{
        didSet{
            navigationItem.title = friend?.name
            
        }
    }
    
    var messages: [Message]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MessageCollectionViewCell
    
        // Configure the cell
        cell.messageTextView.text = messages?[indexPath.item].text
        
        
        return cell
    }

}
