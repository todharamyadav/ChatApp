//
//  Friend+CoreDataProperties.swift
//  Chat
//
//  Created by Dharamvir on 8/19/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Friend {

    @NSManaged var name: String?
    @NSManaged var profileImageName: String?
    @NSManaged var messages: NSSet?
    @NSManaged var lastMessage: Message?

}
