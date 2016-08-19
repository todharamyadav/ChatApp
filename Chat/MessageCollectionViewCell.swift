//
//  MessageCollectionViewCell.swift
//  Chat
//
//  Created by Dharamvir on 8/15/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFontOfSize(18)
        textView.text = "Hello "
        textView.backgroundColor = UIColor.clearColor()
        return textView
    }()
    
    let bubbleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textView.layer.cornerRadius = 15
        textView.layer.masksToBounds = true
        return textView
    }()
    
//    let profileImageview: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .ScaleAspectFit
//        imageView.layer.cornerRadius = 15
//        imageView.layer.masksToBounds = true
//        
//        return imageView
//    }()
    
    func setUpView(){
        
        addSubview(bubbleTextView)
        addSubview(messageTextView)
    

//        addSubview(profileImageview)
//        profileImageview.translatesAutoresizingMaskIntoConstraints = false
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-8-[v0(30)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageview]))
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0(30)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageview]))
//        profileImageview.backgroundColor = UIColor.redColor()
        
    }
}
