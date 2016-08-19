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
            
            FriendViewController.createMessage("My name is Mark..", friend: mark, context: context, minutesAgo: 0)
            
            createSteveMessages(context)
            
            let donald = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
            donald.name = "Donald"
            donald.profileImageName = "Donald"
            
            FriendViewController.createMessage("You are fired", friend: donald, context: context, minutesAgo: 5)
            
            let gandhi = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "Gandhi"
            
            FriendViewController.createMessage("Love Peace and Joy", friend: gandhi, context: context, minutesAgo: 60*24)
            
            let hillary = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "Hillary"
            
            FriendViewController.createMessage("Vote for me.", friend: hillary, context: context, minutesAgo: 60*24*8)

            
            do{
                try (context.save())
            }catch let err{
                print(err)
            }
        }
        
//        loadData()
    }
    
    private func createSteveMessages(context: NSManagedObjectContext){
        let steve = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: context) as! Friend
        steve.name = "Steve Job"
        steve.profileImageName = "Steve"
        
        FriendViewController.createMessage("My name is Steve", friend: steve, context: context, minutesAgo: 3)
        FriendViewController.createMessage("How arre you.. I am asking because it has been long time since i saw you.", friend: steve, context: context, minutesAgo: 2)
        FriendViewController.createMessage("M doing good..I am so glad that u asked me. it has been long time sicne we met and we should hang out sometime in the city or grab beer at a bar. dfjbv jv jdbvh hdjb", friend: steve, context: context, minutesAgo: 1)
        
        //response messages
        FriendViewController.createMessage("Sure..we can go somewhere like how about tomorrow.", friend: steve, context: context, minutesAgo: 1, isSender: true)
        
        FriendViewController.createMessage("Sure..we can go somewhere like how about tomorrow.", friend: steve, context: context, minutesAgo: 1)
        FriendViewController.createMessage("Sure..we can go somewhere like how about tomorrow.", friend: steve, context: context, minutesAgo: 1, isSender: true)
        FriendViewController.createMessage("Sure..we can go somewhere like how about tomorrow.", friend: steve, context: context, minutesAgo: 1)
        FriendViewController.createMessage("Sure..we can go somewhere like how about tomorrow.", friend: steve, context: context, minutesAgo: 1, isSender: true)
    }
    
    static func createMessage(text: String, friend: Friend, context: NSManagedObjectContext, minutesAgo: Double, isSender: Bool = false) -> Message {
        let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as! Message
        message.text = text
        message.date = NSDate().dateByAddingTimeInterval(-minutesAgo * 60)
        message.friend = friend
        message.isSender = NSNumber(bool: isSender)
        
        friend.lastMessage = message
        
        return message
    }
    
//    func loadData(){
//        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
//        
//        if let context = delegate?.managedObjectContext{
//            
//            if let friends = fetchFriends(){
//                messages = [Message]()
//                
//                for friend in friends{
//                    
//                    let fetchRequest = NSFetchRequest(entityName: "Message")
//                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
//                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
//                    fetchRequest.fetchLimit = 1
//                    
//                    do{
//                        let fetchedMessages = try context.executeFetchRequest(fetchRequest) as? [Message]
//                        messages?.appendContentsOf(fetchedMessages!)
//                    }catch let err{
//                        print(err)
//                    }
//                }
//                messages = messages?.sort({$0.date?.compare($1.date!) == .OrderedDescending})
//            }
//            
//        }
//    }
//    
//    func fetchFriends() -> [Friend]?{
//        let delegate = UIApplication.sharedApplication().delegate as? AppDelegate
//        
//        if let context = delegate?.managedObjectContext{
//            let request = NSFetchRequest(entityName: "Friend")
//            
//            do{
//                return try context.executeFetchRequest(request) as? [Friend]
//            }catch let err{
//                print(err)
//            }
//            
//        }
//        
//        return nil
//    }
    
}