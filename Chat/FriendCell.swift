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

    @IBOutlet weak var messageView: MessageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var readReceiptImageView: UIImageView!
    
    
}
