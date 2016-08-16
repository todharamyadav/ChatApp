//
//  FriendCell.swift
//  Chat
//
//  Created by Dharamvir on 8/11/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit

class FriendCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var readReceiptImageView: UIImageView!
    
    override var highlighted: Bool{
        didSet{
            backgroundColor = highlighted ? UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.whiteColor()
            nameLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
            messageLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
            timeLabel.textColor = highlighted ? UIColor.whiteColor() : UIColor.blackColor()
        }
    }
    
    
    var message: Message? {
        didSet{
            messageLabel.text = message?.text
            nameLabel.text = message?.friend?.name
            
            if let profileImageName = message?.friend?.profileImageName{
                profileImageView.image = UIImage(named: profileImageName)
                readReceiptImageView.image = UIImage(named: profileImageName)
            }
            
            if let date = message?.date{
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                let elapsedTimeInSeconds = NSDate().timeIntervalSinceDate(date)
                let secondInDays:NSTimeInterval = 24 * 60 * 60
                
                
                if elapsedTimeInSeconds > 7 * secondInDays{
                    dateFormatter.dateFormat = "MM/dd/yy"
                }else if elapsedTimeInSeconds > secondInDays{
                    dateFormatter.dateFormat = "EEE"
                }
                timeLabel.text = dateFormatter.stringFromDate(date)
            }
        }
    }
    
}
