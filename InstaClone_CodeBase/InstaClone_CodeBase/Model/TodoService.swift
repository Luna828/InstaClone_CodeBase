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
    
    func fetchTodo(for section: String){
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            todoList = try mainContext.fetch(request)
        } catch {
            print("ERROR")
        }
    }
    
    func addNewTodo(_ todo: Todo, to section: String) {
        let truncatedContent = String(todo.content?.prefix(10) ?? "") + (todo.content?.count ?? 0 > 10 ? "..." : "")
        
        todo.section = section
        
        todo.id = UUID()
        todo.content = truncatedContent
        todo.date = Date()
        todo.isChecked = false
    
        todoList.insert(todo, at: 0)
        saveContext()
    }
    
    func deleteTodo(_ todo: Todo?){
        if let todo = todo {
            mainContext.delete(todo)
            saveContext()
        }
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
