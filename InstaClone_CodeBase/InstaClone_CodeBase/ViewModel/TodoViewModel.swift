import Foundation

class TodoViewModel {
    let todoService = TodoService.shared
    var sectionNames: [String] = ["Work", "Life"]
    
    var todoListDidChange: (() -> Void)?
    
    func fetchTodos(for sectionName: String) {
        todoService.fetchTodo(for: sectionName)
    }
    
    func addNewTodo(content: String, to sectionName: String) {
        if content.isEmpty {
            return
        }
        
        let newTodo = Todo(context: todoService.mainContext)
        newTodo.content = content
        todoService.addNewTodo(newTodo, to: sectionName)
        todoListDidChange?()
    }
}
