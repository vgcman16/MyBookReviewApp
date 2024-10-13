import Foundation

class ReadingGoalService: ObservableObject {
    @Published var currentGoal: ReadingGoal?
    
    init() {
        loadGoal()
    }
    
    func loadGoal() {
        if let data = UserDefaults.standard.data(forKey: "readingGoal"),
           let savedGoal = try? JSONDecoder().decode(ReadingGoal.self, from: data) {
            currentGoal = savedGoal
        }
    }
    
    func setGoal(_ goal: ReadingGoal) {
        currentGoal = goal
        saveGoal()
    }
    
    func updateBooksRead(_ count: Int) {
        currentGoal?.booksRead = count
        saveGoal()
    }
    
    private func saveGoal() {
        if let goal = currentGoal,
           let encodedData = try? JSONEncoder().encode(goal) {
            UserDefaults.standard.set(encodedData, forKey: "readingGoal")
        }
    }
}