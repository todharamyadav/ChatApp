//
//  chatLogCollectionViewController.swift
//  Chat
//
//  Created by Dharamvir on 8/15/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class chatLogCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var friend: Friend?{
        didSet{
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sort({$0.date?.compare($1.date!) == .OrderedAscending})
        }
    }
    
    var messages: [Message]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.registerClass(MessageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MessageCollectionViewCell
    
        // Configure the cell
        cell.messageTextView.text = messages?[indexPath.item].text
        
        if let messageText = messages?[indexPath.item].text{
            
            
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
            
            
            cell.messageTextView.frame = CGRectMake(8, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
            cell.bubbleTextView.frame = CGRectMake(0, 0, estimatedFrame.width + 8 + 16, estimatedFrame.height + 20)
//            cell.profileImageview.image = UIImage(named: profileImageName)

        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        if let messageText = messages?[indexPath.item].text{
            
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
            
            return CGSizeMake(view.frame.width, estimatedFrame.height+20)
        }
        return CGSizeMake(view.frame.width, 100)
    }

}
