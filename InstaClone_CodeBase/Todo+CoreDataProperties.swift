//
//  Todo+CoreDataProperties.swift
//  InstaClone_CodeBase
//
//  Created by t2023-m0050 on 2023/09/15.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isChecked: Bool

}

extension Todo : Identifiable {

}
