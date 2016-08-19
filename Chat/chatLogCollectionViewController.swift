//
//  chatLogCollectionViewController.swift
//  Chat
//
//  Created by Dharamvir on 8/15/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class chatLogCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    var friend: Friend?{
        didSet{
            navigationItem.title = friend?.name
//            messages = friend?.messages?.allObjects as? [Message]
//            messages = messages?.sort({$0.date?.compare($1.date!) == .OrderedAscending})
        }
    }
    
    //var messages: [Message]?
    
    let messageInputContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message..."
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("Send", forState: .Normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, forState: .Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(16)
        button.addTarget(self, action: #selector(handleSend), forControlEvents: .TouchUpInside)
        return button
    }()
    
    func handleSend(){
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
//        let message = FriendViewController.createMessage(inputTextField.text!, friend: friend!, context: context, minutesAgo: 0, isSender: true)
        FriendViewController.createMessage(inputTextField.text!, friend: friend!, context: context, minutesAgo: 0, isSender: true)
        do{
            try context.save()
            inputTextField.text = nil
//            messages?.append(message)
//            
//            let insertionIndexPath = NSIndexPath(forItem: messages!.count - 1, inSection: 0)
//            collectionView?.insertItemsAtIndexPaths([insertionIndexPath])
//            self.collectionView?.scrollToItemAtIndexPath(insertionIndexPath, atScrollPosition: .Bottom, animated: true)
//            inputTextField.text = nil
            
        } catch let err{
            print(err)
        }
        
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    func simulate(){
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
//        let message = FriendViewController.createMessage("Here is a text message send ", friend: friend!, context: context, minutesAgo: 2)
        FriendViewController.createMessage("Here is a text message send ", friend: friend!, context: context, minutesAgo: 0)
        FriendViewController.createMessage("and that is it ", friend: friend!, context: context, minutesAgo: 0)
        do{
            try context.save()
            
//            messages?.append(message)
//            messages = messages?.sort({$0.date?.compare($1.date!) == .OrderedAscending})
//            
//            if let item = messages?.indexOf(message){
//                let indexPath = NSIndexPath(forItem: item, inSection: 0)
//                collectionView?.insertItemsAtIndexPaths([indexPath])
//            }
            
        }
        catch let err{
        print(err)
        }
    }
    
    lazy var fetchedRequestController: NSFetchedResultsController = {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Message")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "friend.name = %@", self.friend!.name!)
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    var blockOperations = [NSBlockOperation]()
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if type == .Insert{
            blockOperations.append(NSBlockOperation(block: {
                self.collectionView?.insertItemsAtIndexPaths([newIndexPath!])
            }))
            //collectionView?.scrollToItemAtIndexPath(newIndexPath!, atScrollPosition: .Bottom, animated: true)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView?.performBatchUpdates({
            for operation in self.blockOperations{
                operation.start()
            }
            }, completion: { (completed) in
                let lastItem = self.fetchedRequestController.sections![0].numberOfObjects - 1
                let indexPath = NSIndexPath(forItem: lastItem, inSection: 0)
                self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedRequestController.performFetch()
        }
        catch let err{
            print(err)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simulate", style: .Plain, target: self, action: #selector(simulate))
        
        collectionView?.registerClass(MessageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
        
        view.addSubview(messageInputContainerView)
        view.addConstraintWithVisualFormat("H:|[v0]|", views: messageInputContainerView)
        view.addConstraintWithVisualFormat("V:[v0(48)]", views: messageInputContainerView)
        
        bottomConstraint = NSLayoutConstraint(item: messageInputContainerView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        setUpInputComponenets()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(handleKeyBoardNotification), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(handleKeyBoardNotification), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func handleKeyBoardNotification(notification: NSNotification){
        if let userInfo = notification.userInfo{
            let keyBoardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
            //print(notification.name)
            
            let isKeyBoardShowing = notification.name == UIKeyboardWillShowNotification
            
            bottomConstraint?.constant = isKeyBoardShowing ? -keyBoardFrame!.height:0
            
            UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.view.layoutIfNeeded()
                }, completion: { (completed) in
                    
//                    if isKeyBoardShowing{
//                        let indexPath = NSIndexPath(forItem: self.messages!.count - 1, inSection: 0)
//                        self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
//                    }
                    let lastItem = self.fetchedRequestController.sections![0].numberOfObjects - 1
                    let indexPath = NSIndexPath(forItem: lastItem, inSection: 0)
                    self.collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
            })
        }
    }
    
    
    private func setUpInputComponenets(){
        let topBorderView = UIView()
        topBorderView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(topBorderView)
        
        messageInputContainerView.addConstraintWithVisualFormat("H:|-8-[v0][v1(60)]|", views: inputTextField, sendButton)
        messageInputContainerView.addConstraintWithVisualFormat("V:|[v0]|", views: inputTextField)
        messageInputContainerView.addConstraintWithVisualFormat("V:|[v0]|", views: sendButton)
        messageInputContainerView.addConstraintWithVisualFormat("H:|[v0]|", views: topBorderView)
        messageInputContainerView.addConstraintWithVisualFormat("V:|[v0(0.5)]", views: topBorderView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedRequestController.sections?[0].numberOfObjects{
            return count
        }
        return 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MessageCollectionViewCell
    
        // Configure the cell
        
        let message = fetchedRequestController.objectAtIndexPath(indexPath) as! Message
        
        cell.messageTextView.text = message.text
        
        if let messageText = message.text{
            
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
            
            if(!message.isSender!.boolValue){
                cell.messageTextView.frame = CGRectMake(8 + 8, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
                cell.bubbleTextView.frame = CGRectMake(8, 0, estimatedFrame.width + 8 + 16, estimatedFrame.height + 20)
                cell.bubbleTextView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.blackColor()
            }else{
                cell.messageTextView.frame = CGRectMake(view.frame.width - estimatedFrame.width - 16 - 8, 0, estimatedFrame.width + 16, estimatedFrame.height + 20)
                cell.bubbleTextView.frame = CGRectMake(view.frame.width - estimatedFrame.width - 8 - 16 - 8, 0, estimatedFrame.width + 8 + 16, estimatedFrame.height + 20)
                cell.bubbleTextView.backgroundColor = UIColor(red: 0, green: 37/255, blue: 249/255, alpha: 1)
                cell.messageTextView.textColor = UIColor.whiteColor()

            }
            
//            cell.profileImageview.image = UIImage(named: profileImageName)

        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(8, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let message = fetchedRequestController.objectAtIndexPath(indexPath) as! Message
        if let messageText = message.text{
            
            let size = CGSizeMake(250, 1000)
            let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
            
            let estimatedFrame = NSString(string: messageText).boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(18)], context: nil)
            
            return CGSizeMake(view.frame.width, estimatedFrame.height+20)
        }
        return CGSizeMake(view.frame.width, 100)
    }

}
