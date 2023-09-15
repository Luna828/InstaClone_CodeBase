import CoreData
import UIKit

class TodoService {
    static let shared = TodoService()
    private init(){}
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //READ
    var todoList = [Todo]()
    
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
        newTodo.id = UUID()
        newTodo.content = todo
        newTodo.date = Date()
        newTodo.isChecked = false
        
        todoList.insert(newTodo, at: 0)
        saveContext()
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved Error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext(){
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
