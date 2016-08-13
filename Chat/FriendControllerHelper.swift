//
//  FriendControllerHelper.swift
//  Chat
//
//  Created by Dharamvir on 8/12/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit
import CoreData

//class Friend:NSObject{
//    var name: String?
//    var profileImageName: String?
//}
//
//class Message:NSObject{
//    var text: String?
//    var date: NSDate?
//    var friend: Friend?
//
//    
//}

extension FriendViewController{
    
    func clearData(){
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if let context = delegate?.managedObjectContext{
            
            do{
                let entityNames = ["Friend","Message"]
                
                for entityName in entityNames{
                    let fetchRequest = NSFetchRequest(entityName: entityName)
                    let objects = try (context.executeFetchRequest(fetchRequest)) as? [NSManagedObject]
                    
                    for object in objects!{
                        context.deleteObject(object)
                    }
                }
                
                try context.save()
                
            }catch let err{
                print(err)
            }
            
            
        }
    }
    
    func setUpData(){
        
        clearData()
        
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if let context = delegate?.managedObjectContext{
            let mark = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "Mark"
            
            let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message
            message.text = "Hello, My name is Mark. Nice to meet you.."
            message.date = NSDate()
            message.friend = mark
            
            let steve = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
            steve.name = "Steve Job"
            steve.profileImageName = "Steve"
            
            let steveMessage = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message
            steveMessage.text = "Hello, My name is Steve. Nice to meet you.."
            steveMessage.date = NSDate()
            steveMessage.friend = steve
            
            do{
                try (context.save())
            }catch let err{
                print(err)
            }
            
            //messages = [message,steveMessage]
        }
        
        loadData()
    }
    
    func loadData(){
        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if let context = delegate?.managedObjectContext{
            let fetchRequest = NSFetchRequest(entityName: "Message")
            
            do{
                messages = try context.executeFetchRequest(fetchRequest) as? [Message]
            }catch let err{
                print(err)
            }
            
            
        }
    }
}
