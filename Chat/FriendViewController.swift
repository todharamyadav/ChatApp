//
//  ViewController.swift
//  Chat
//
//  Created by Dharamvir on 8/11/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit
import CoreData

class FriendViewController: UICollectionViewController {

    var messages: [Message]?
    
    lazy var fetchResultController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Friend")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastMessage.date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "lastMessage != nil")
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = delegate.managedObjectContext
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //collectionView?.registerClass(FriendCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
        
        setUpData()
        
        do{
            try fetchResultController.performFetch()
        }
        catch let err{
            print(err)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchResultController.sections?[section].numberOfObjects{
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
        
        let friend = fetchResultController.objectAtIndexPath(indexPath) as! Friend
        
        cell.message = friend.lastMessage
        
        
        
//        if let message = messages?[indexPath.item]{
//            cell.message = message
//            
//        }
        
        return cell
        
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ShowMessages"{
//            let destination = segue.destinationViewController as! chatLogCollectionViewController
//            
//            if let selectedCell = sender as? FriendCell{
//                let indexPath = collectionView?.indexPathForCell(selectedCell)
//                destination.friend = messages?[indexPath!.item].friend
//            }
//        }
//    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let layout = UICollectionViewFlowLayout()
        let controller = chatLogCollectionViewController(collectionViewLayout: layout)
        let friend = fetchResultController.objectAtIndexPath(indexPath) as! Friend
        controller.friend = friend
        navigationController?.pushViewController(controller, animated: true)
        
    }
}

