import SwiftUI

struct ReadingGoalView: View {
    @StateObject private var goalService = ReadingGoalService()
    @State private var showingSetGoal = false
    
    var body: some View {
        VStack {
            if let goal = goalService.currentGoal {
                VStack(alignment: .leading) {
                    Text("Current Goal: \(goal.booksRead)/\(goal.booksGoal) books")
                        .font(.headline)
                    Text("End Date: \(goal.endDate, style: .date)")
                    ProgressView(value: Double(goal.booksRead), total: Double(goal.booksGoal))
                }
                .padding()
                
                Button("Update Progress") {
                    goalService.updateBooksRead(goal.booksRead + 1)
                }
            } else {
                Text("No current reading goal")
                    .font(.headline)
                Button("Set a Goal") {
                    showingSetGoal = true
                }
            }
        }
        .sheet(isPresented: $showingSetGoal) {
            SetGoalView(goalService: goalService)
        }
    }
}

struct SetGoalView: View {
    @ObservedObject var goalService: ReadingGoalService
    @Environment(\.presentationMode) var presentationMode
    
    @State private var booksGoal = 10
    @State private var endDate = Date().addingTimeInterval(30 * 24 * 60 * 60) // 30 days from now
    
    var body: some View {
        NavigationView {
            Form {
                Stepper("Books to read: \(booksGoal)", value: $booksGoal, in: 1...100)
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
            }
            .navigationTitle("Set Reading Goal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newGoal = ReadingGoal(booksGoal: booksGoal, startDate: Date(), endDate: endDate, booksRead: 0)
                        goalService.setGoal(newGoal)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}