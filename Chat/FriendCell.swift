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
                timeLabel.text = dateFormatter.stringFromDate(date)
            }
        }
    }
    
}
