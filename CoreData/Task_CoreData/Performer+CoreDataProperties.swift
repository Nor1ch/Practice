//
//  Performer+CoreDataProperties.swift
//  Task_CoreData
//
//  Created by Nor1 on 22.05.2022.
//
//

import Foundation
import CoreData


extension Performer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Performer> {
        return NSFetchRequest<Performer>(entityName: "Performer")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastName: String?
    @NSManaged public var birth: String?
    @NSManaged public var country: String?

}

extension Performer : Identifiable {

}
