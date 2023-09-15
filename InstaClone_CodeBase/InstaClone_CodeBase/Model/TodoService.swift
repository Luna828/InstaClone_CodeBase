import CoreData
import UIKit

class TodoService {
    static let shared = TodoService()
    private init() {}
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // READ
    var todoList: [Todo] = []
    
    func initializeDummyDataIfNeeded() {
        if todoList.isEmpty {
            addNewTodo("MVVM 공부 및 CoreData도..")
            addNewTodo("12시안에자기")
        }
    }
    
    func fetchTodo() {
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            todoList = try mainContext.fetch(request)
        } catch {
            print("ERROR")
        }
    }
    
    func addNewTodo(_ todo: String) {
        let newTodo = Todo(context: mainContext)
        
        let truncatedContent = String(todo.prefix(10)) + (todo.count > 10 ? "..." : "")
        
        newTodo.setValue(UUID(), forKey: "id")
        newTodo.setValue(truncatedContent, forKey: "content")
        newTodo.setValue(Date(), forKey: "date")
        newTodo.setValue(false, forKey: "isChecked")
        
        todoList.insert(newTodo, at: 0)
        saveContext()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores(completionHandler: {
            _, error in
            if let error = error as NSError? {
                fatalError("Unresolved Error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved  error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
