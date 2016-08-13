//
//  Message+CoreDataProperties.swift
//  Chat
//
//  Created by Dharamvir on 8/12/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Message {

    @NSManaged var text: String?
    @NSManaged var date: NSDate?
    @NSManaged var friend: Friend?

}
