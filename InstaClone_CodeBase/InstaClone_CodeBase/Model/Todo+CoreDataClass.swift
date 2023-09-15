import Foundation
import CoreData

@objc(Todo)
public class Todo: NSManagedObject {}

extension Todo {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var id: UUID
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var isChecked: Bool

}
